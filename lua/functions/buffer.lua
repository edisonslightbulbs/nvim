-- table for buffer functions and variables
_G.config.buffer = {}

config.buffer._disk_state = {}
config.buffer._disk_conflict_notified = {}

local uv = vim.uv or vim.loop
local max_tracked_file_size = 1024*1024

local function read_file_bytes(path, stat)
    if config.str.empty(path) then
        return nil
    end

    if stat ~= nil then
        if stat.type ~= 'file' or stat.size > max_tracked_file_size then
            return nil
        end
    end

    local file = io.open(path, 'rb')
    if file == nil then
        return nil
    end

    local content = file:read('*a')
    file:close()
    return content
end

local function file_state_key(stat)
    if not stat then
        return nil
    end

    local mtime = stat.mtime or {}
    return table.concat({
        stat.type or '',
        stat.size or 0,
        mtime.sec or 0,
        mtime.nsec or 0,
    }, ':')
end

local function display_path(path)
    if config.str.empty(path) then
        return '[unnamed buffer]'
    end

    return vim.fn.fnamemodify(path, ':~:.')
end

local function set_disk_state(bufid, filename, stat)
    config.buffer._disk_state[bufid] = {
        path = filename,
        stamp = file_state_key(stat),
        existed = stat ~= nil,
        content = read_file_bytes(filename, stat),
    }
    config.buffer._disk_conflict_notified[bufid] = nil
end

config.buffer.refresh_if_content_unchanged = function(bufid)
    bufid = bufid or 0

    local ok, filename, stat = config.buffer.file_target(bufid)
    if not ok or stat == nil then
        return false
    end

    local previous = config.buffer._disk_state[bufid]
    if previous == nil or previous.path ~= filename or previous.content == nil then
        return false
    end

    local content = read_file_bytes(filename, stat)
    if content ~= nil and content == previous.content then
        set_disk_state(bufid, filename, stat)
        return true
    end

    return false
end

-- returns buffer count including no name buffer
config.buffer.count = function()
	return vim.fn.len(vim.fn.getbufinfo({ buflisted = true }))
end

-- returns true or false on last buffer check
config.buffer.last = function()
	if config.buffer.count() <= 1 then
		return true
	end
	return false
end

-- returns true or false on noname buffer check
config.buffer.noname = function()
	if
		vim.bo.modifiable
		and config.str.empty(vim.bo.buftype)
		and config.str.empty(vim.fn.expand('%'))
		and config.str.empty(vim.bo.filetype)
	then
		return true
	end
	return false
end

config.buffer.file_target = function(bufid)
    bufid = bufid or 0

    local filename = vim.api.nvim_buf_get_name(bufid)
    if config.str.empty(filename) then
        return false, nil, nil
    end

    local stat = uv.fs_stat(filename)
    if stat ~= nil and stat.type ~= 'file' then
        return false, filename, stat
    end

    return true, filename, stat
end

config.buffer.track_disk_state = function(bufid)
    bufid = bufid or 0

    local ok, filename, stat = config.buffer.file_target(bufid)
    if ok and stat ~= nil then
        set_disk_state(bufid, filename, stat)
        return
    end

    config.buffer._disk_state[bufid] = nil
    config.buffer._disk_conflict_notified[bufid] = nil
end

config.buffer.clear_disk_state = function(bufid)
    bufid = bufid or 0
    config.buffer._disk_state[bufid] = nil
    config.buffer._disk_conflict_notified[bufid] = nil
end

config.buffer.disk_changed = function(bufid)
    bufid = bufid or 0

    local ok, filename, stat = config.buffer.file_target(bufid)
    if not ok then
        return true, filename, 'not a regular file'
    end

    local previous = config.buffer._disk_state[bufid]
    if stat == nil then
        if previous ~= nil and previous.existed then
            return true, filename, 'deleted outside Neovim'
        end

        return false, filename, nil
    end

    if previous == nil or previous.path ~= filename then
        set_disk_state(bufid, filename, stat)
        return false, filename, nil
    end

    if file_state_key(stat) ~= previous.stamp then
        if config.buffer.refresh_if_content_unchanged(bufid) then
            return false, filename, nil
        end

        return true, filename, 'changed outside Neovim'
    end

    return false, filename, nil
end

config.buffer.notify_disk_conflict = function(bufid, action, reason)
    bufid = bufid or 0

    if config.buffer._disk_conflict_notified[bufid] then
        return
    end

    local _, filename = config.buffer.file_target(bufid)
    local reason_text = ''
    if not config.str.empty(reason) then
        reason_text = ' (' .. reason .. ')'
    end

    config.buffer._disk_conflict_notified[bufid] = true
    vim.notify(
        (action or 'Write')
            .. ' skipped'
            .. reason_text
            .. ': file changed outside Neovim. Reload or compare before writing: '
            .. display_path(filename),
        vim.log.levels.WARN
    )
end

-- returns true or false on buffer writable check
config.buffer.writable = function(bufid)
    bufid = bufid or 0
    local bo = vim.bo[bufid]

    -- check for NvimTree buffer
    if bo.filetype == 'NvimTree' then
        return false
    end

    -- check for unnamed buffer
    if config.str.empty(vim.api.nvim_buf_get_name(bufid)) then
        return false
    end

    -- check if buffer is modifiable
    if not bo.modifiable then
        return false
    end

    -- check if buffer is associated with a regular file target or a new file path
    local target_ok, filename, stat = config.buffer.file_target(bufid)
    if not target_ok or filename == '' or filename == nil then
        return false
    end

    -- check for special buffer types (like help, quickfix, etc.)
    if bo.buftype ~= '' then
        return false
    end

    -- check if buffer is read-only
    if bo.readonly then
        return false
    end

    -- optional: Check for large files
    if stat ~= nil and stat.size > max_tracked_file_size then -- 1 MB limit
        return false
    end

    -- check if buffer is modified
    if not bo.modified then
        return false
    end

    return true
end

config.buffer.savable = function(bufid)
    return config.buffer.writable(bufid)
end

config.buffer.safe_update = function(action, require_savable, bufid)
    action = action or 'Write'
    bufid = bufid or 0

    if require_savable == false then
        local bo = vim.bo[bufid]
        local target_ok = config.buffer.file_target(bufid)
        if not target_ok or bo.buftype ~= '' or not bo.modifiable or bo.readonly or not bo.modified then
            return false
        end
    elseif not config.buffer.savable(bufid) then
        return false
    end

    local changed, _, reason = config.buffer.disk_changed(bufid)
    if changed then
        config.buffer.notify_disk_conflict(bufid, action, reason)
        return false
    end

    local ok, err = pcall(vim.api.nvim_buf_call, bufid, function()
        vim.cmd('silent update')
    end)
    if not ok then
        vim.notify((action or 'Write') .. ' failed: ' .. tostring(err), vim.log.levels.ERROR)
        return false
    end

    if vim.bo[bufid].modified then
        return false
    end

    config.buffer.track_disk_state(bufid)
    return true
end

-- returns true or false on work buffer check
config.buffer.work = function(bufid)
	if
		vim.fn.buflisted(bufid)
		and vim.fn.bufloaded(bufid) == 1
		and not config.str.empty(vim.fn.bufname(bufid))
		and vim.fn.bufname(bufid) ~= 'NvimTree_1'
	then
		return true
	end
	return false
end

-- navigate to next buffer
config.buffer.next = function()
    if not config.buffer.work(vim.fn.bufnr('%')) then
        return -- Exit if the current buffer is not a work buffer
    end

    local current_bufnr = vim.fn.bufnr('%')
    local next_bufnr = current_bufnr

    repeat
        next_bufnr = (next_bufnr % vim.fn.bufnr('$')) + 1
        if next_bufnr == current_bufnr then
            return -- Avoid infinite loop if no other valid buffer is found
        end
    until config.buffer.work(next_bufnr)

    vim.api.nvim_command('buffer ' .. next_bufnr)
end

-- navigate to previous buffer
config.buffer.previous = function()
    if not config.buffer.work(vim.fn.bufnr('%')) then
        return -- Exit if the current buffer is not a work buffer
    end

    local current_bufnr = vim.fn.bufnr('%')
    local prev_bufnr = current_bufnr

    repeat
        prev_bufnr = prev_bufnr - 1
        if prev_bufnr < 1 then
            prev_bufnr = vim.fn.bufnr('$')
        end
        if prev_bufnr == current_bufnr then
            return -- Avoid infinite loop if no other valid buffer is found
        end
    until config.buffer.work(prev_bufnr)

    vim.api.nvim_command('buffer ' .. prev_bufnr)
end

-- unload (close) all open buffers except current one
config.buffer.unloadall = function()
    local current_bufnr = vim.fn.bufnr('%')
    local buffers_to_delete = {}

    for bufid = 1, vim.fn.bufnr('$') do
        if bufid ~= current_bufnr and vim.api.nvim_buf_is_loaded(bufid) and config.buffer.work(bufid) then
            table.insert(buffers_to_delete, bufid)
        end
    end

    for _, bufid in ipairs(buffers_to_delete) do
        pcall(vim.api.nvim_buf_delete, bufid, {force = true, unload = false})
    end

    -- Increase the delay slightly
    vim.defer_fn(function()
        vim.cmd('redraw!')
    end, 300)  -- delay of 200 milliseconds
end

-- unload current buffer
config.buffer.unload = function()
	if config.buffer.count() > 1 then
		vim.api.nvim_command('bp |bd #')
	else
		vim.api.nvim_command('bd!')
	end
end

config.buffer.strip = function()
  local target_ok = config.buffer.file_target(0)
  if not target_ok or vim.bo.buftype ~= '' or not vim.bo.modifiable or vim.bo.readonly then
    vim.notify('Strip skipped: buffer is not a writable regular file.', vim.log.levels.WARN)
    return
  end

  local changed, _, reason = config.buffer.disk_changed(0)
  if changed then
    config.buffer.notify_disk_conflict(0, 'Strip', reason)
    return
  end

  -- Save the current cursor position, window view, and mode
  local pos = vim.api.nvim_win_get_cursor(0)
  local view = vim.fn.winsaveview()
  local mode = vim.api.nvim_get_mode().mode

  -- Ensure we are in normal mode (exit insert mode)
  vim.cmd('call feedkeys("\\<esc>")')

  -- Strip trailing whitespace, clear search highlighting, convert to Unix line endings, and save
  vim.cmd('%s/\\s\\+$//e')
  vim.cmd('let @/=""')
  if vim.bo.fileformat ~= 'unix' then
    vim.bo.fileformat = 'unix'
  end

  local saved = true
  if vim.bo.modified then
    saved = config.buffer.safe_update('Strip', false, 0)
  end

  -- Restore the original window view and cursor position
  vim.fn.winrestview(view)
  vim.api.nvim_win_set_cursor(0, pos)

  -- Restore insert mode if that was the original mode
  if mode:sub(1,1) == "i" then
    vim.cmd('startinsert')
  end

  if not saved then
    return
  end
end
