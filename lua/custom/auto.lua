-- reload buffer on 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter'  events
local file_state = vim.api.nvim_create_augroup('FileState', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'BufFilePost' }, {
    pattern = '*',
    group = file_state,
    desc = 'tracks disk state for guarded writes',
    callback = function(args)
        config.buffer.track_disk_state(args.buf)
    end,
})

vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
    pattern = '*',
    group = file_state,
    desc = 'clears tracked disk state for deleted buffers',
    callback = function(args)
        config.buffer.clear_disk_state(args.buf)
    end,
})

local file_change = vim.api.nvim_create_augroup('FileChangeGuard', { clear = true })
vim.api.nvim_create_autocmd('FileChangedShell', {
    pattern = '*',
    group = file_change,
    desc = 'prevents interactive external-change prompts',
    callback = function(args)
        if vim.bo[args.buf].modified then
            vim.v.fcs_choice = ''
            if config.buffer.refresh_if_content_unchanged(args.buf) then
                return
            end

            config.buffer.notify_disk_conflict(args.buf, 'External change', vim.v.fcs_reason)
            return
        end

        if vim.v.fcs_reason == 'deleted' then
            vim.v.fcs_choice = ''
            config.buffer.clear_disk_state(args.buf)
            return
        end

        vim.v.fcs_choice = 'edit'
    end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
    pattern = '*',
    group = file_change,
    desc = 'refreshes tracked disk state after external-change handling',
    callback = function(args)
        config.buffer.track_disk_state(args.buf)
    end,
})

for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
        config.buffer.track_disk_state(bufnr)
    end
end

local autoreload = vim.api.nvim_create_augroup('Reload', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter' }, {
	pattern = {'*.yml', '*.yaml', '*.h', '*.hpp', '*.cpp', '*.py', '*.metainfo', '*.json'},
	group = autoreload,
	desc = 'Reloads buf if file modified outside nvim',
	callback = function(args)
        if vim.bo[args.buf].modified then
            local changed, _, reason = config.buffer.disk_changed(args.buf)
            if changed then
                config.buffer.notify_disk_conflict(args.buf, 'Auto-reload', reason)
            end
            return
        end

		pcall(vim.api.nvim_command, 'silent! checktime ' .. args.buf)
        config.buffer.track_disk_state(args.buf)
	end,
})

-- remove readonly on 'BufEnter' for all files
local noreadonly = vim.api.nvim_create_augroup('DiffMode', { clear = true })
vim.api.nvim_create_autocmd(
    {'BufEnter'},
    {
        pattern = '*',
        group = noreadonly,
        desc = 'removes readonly from git diffs',
        callback = function()
            -- only remove readonly if in diff mode
            if vim.api.nvim_win_get_option(0, 'diff') then
                vim.opt.readonly = false
            end
        end,
    }
)

-- remove conceal on 'BufEnter' and 'CursorMoved'
local conceal = vim.api.nvim_create_augroup('UnConceal', { clear = true })
vim.api.nvim_create_autocmd(
    { 'BufEnter', 'CursorMoved' },
    {
        pattern = { '*.json' },
        group = conceal,
        desc = 'un-conceal in *.json files',
        callback = function()
            vim.api.nvim_win_set_option(0, 'conceallevel', 0)
        end,
    }
)

-- save on text changes, buffer/window changes, command-line leave, and exit
local autosave_enabled = true
local autosave_timers = {}
local autosave_interval = 750 -- ms

local function stop_autosave_timer(bufid)
	local timer_id = autosave_timers[bufid]
	if timer_id then
		vim.fn.timer_stop(timer_id)
		autosave_timers[bufid] = nil
	end
end

local function save_buffer(bufid)
	if not autosave_enabled then
		return false
	end

	bufid = bufid or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(bufid) or not vim.api.nvim_buf_is_loaded(bufid) then
		return false
	end

	stop_autosave_timer(bufid)
	return config.buffer.safe_update('Autosave', nil, bufid)
end

local function schedule_save_buffer(bufid)
	if not autosave_enabled then
		return
	end

	bufid = bufid or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(bufid) or not vim.api.nvim_buf_is_loaded(bufid) then
		return
	end

	stop_autosave_timer(bufid)
	autosave_timers[bufid] = vim.fn.timer_start(autosave_interval, function()
		autosave_timers[bufid] = nil
		vim.schedule(function()
			save_buffer(bufid)
		end)
	end)
end

local function flush_autosave()
	local pending_buffers = {}
	for bufnr, _ in pairs(autosave_timers) do
		table.insert(pending_buffers, bufnr)
	end

	for _, bufnr in ipairs(pending_buffers) do
		stop_autosave_timer(bufnr)
	end

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		save_buffer(bufnr)
	end
end

local autosave = vim.api.nvim_create_augroup('Autosave', { clear = true })
vim.api.nvim_create_autocmd(
	{ 'TextChanged', 'TextChangedI', 'TextChangedP', 'CursorMoved', 'CursorHold', 'CursorHoldI' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'autosave changed buffers after editing pauses',
		callback = function(args)
			schedule_save_buffer(args.buf)
		end,
	}
)

vim.api.nvim_create_autocmd(
	{ 'InsertLeave', 'BufLeave', 'WinLeave', 'CmdlineLeave', 'CmdwinLeave', 'FocusLost' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'autosave buffers before leaving editing contexts',
		callback = function(args)
			save_buffer(args.buf)
		end,
	}
)

vim.api.nvim_create_autocmd(
	{ 'BufDelete', 'BufWipeout' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'clears pending autosave timers for deleted buffers',
		callback = function(args)
			stop_autosave_timer(args.buf)
		end,
	}
)

-- Handle exit events separately so pending draft/text edits are flushed synchronously.
vim.api.nvim_create_autocmd(
	{ 'ExitPre', 'VimLeavePre' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'flush autosave before exit',
		callback = function()
			flush_autosave()
			autosave_enabled = false
		end,
	}
)
