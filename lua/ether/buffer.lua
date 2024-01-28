-- table for buffer functions and variables
_G.config.buffer = {}

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

-- returns true or false on buffer writable check
config.buffer.writable = function()
    -- check for NvimTree buffer
    if vim.bo.filetype == 'NvimTree' then
        return false
    end

    -- check for unnamed buffer
    if config.str.empty(vim.fn.expand('%')) then
        return false
    end

    -- check if buffer is modifiable
    if not vim.bo.modifiable then
        return false
    end

    -- check if buffer is associated with a file
    local filename = vim.fn.expand('%')
    if filename == '' or filename == nil then
        return false
    end

    -- check for special buffer types (like help, quickfix, etc.)
    if vim.bo.buftype ~= '' then
        return false
    end

    -- check if buffer is read-only
    if vim.bo.readonly then
        return false
    end

    -- check if buffer has a valid filetype
    if config.str.empty(vim.bo.filetype) then
        return false
    end

    -- optional: Check for large files
    if vim.fn.getfsize(vim.fn.expand('%')) > 1024*1024 then -- 1 MB limit
        return false
    end

    -- check if buffer is modified
    if not vim.bo.modified then
        return false
    end

    return true
end

config.buffer.savable = function()
    return config.buffer.writable()
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

-- strip trailing white spaces
config.buffer.strip = function()
	vim.api.nvim_command(':call feedkeys("\\<esc>")')
	vim.api.nvim_command('%s/\\s\\+$//e')
	vim.api.nvim_command('let @/=""')
end
