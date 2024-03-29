-- reload buffer on 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter'  events
local autoreload = vim.api.nvim_create_augroup('Reload', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter' }, {
	pattern = {'*.yml', '*.yaml', '*.h', '*.hpp', '*.cpp', '*.py', '*.metainfo', '*.json'},
	group = autoreload,
	desc = 'Reloads buf if file modified outside nvim',
	callback = function()
		vim.api.nvim_command('checktime')
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
        pattern = { '*.md', '*.json' },
        group = conceal,
        desc = 'un-conceal in *.md and *.json files',
        callback = function()
            vim.api.nvim_win_set_option(0, 'conceallevel', 0)
        end,
    }
)

-- save on 'InsertLeave', 'BufLeave', 'WinLeave', 'CmdlineLeave', 'ExitPre'
local autosave_enabled = true

local function save_buffer()
	if autosave_enabled and config.buffer.savable() then
		vim.cmd('silent write')
	end
end

local function debounce(func, delay)
	local timer_id

	return function(...)
		if timer_id then
			vim.fn.timer_stop(timer_id)
		end

		local args = { ... }
		timer_id = vim.fn.timer_start(delay, function()
			func(unpack(args))
		end)
	end
end

local autosave_interval = 10 -- ms
local debounced_save_buffer = debounce(save_buffer, autosave_interval)

local autosave = vim.api.nvim_create_augroup('Autosave', { clear = true })
vim.api.nvim_create_autocmd(
	{ 'InsertLeave', 'BufLeave', 'WinLeave', 'CmdlineLeave', 'CursorMoved', 'CmdwinLeave' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'autosave buffers',
		callback = function()
			debounced_save_buffer()
		end,
	}
)

-- Handle ExitPre event separately
vim.api.nvim_create_autocmd(
	{ 'ExitPre' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'handle exit event',
		callback = function()
			autosave_enabled = false
		end,
	}
)
