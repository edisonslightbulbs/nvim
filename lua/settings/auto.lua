-- reload buffer on 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter'  events
local autoreload = vim.api.nvim_create_augroup('Reload', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter' }, {
	pattern = {'*.yml', '*.h', '*.cpp', '*.py', '*.metainfo', '*.json'},
	group = autoreload,
	desc = 'reloads buf if file modified outside nvim',
	callback = function()
		vim.api.nvim_command('checktime')
	end,
})

-- remove readonly on 'BufEnter'
local noreadonly = vim.api.nvim_create_augroup('DiffMode', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	group = noreadonly,
	desc = 'removes readonly from git diffs',
	callback = function()
		if vim.api.nvim_win_get_option(0, 'diff') then
			vim.opt.readonly = false
		end
	end,
})

-- remove conceal on 'BufEnter'
local conceal = vim.api.nvim_create_augroup('UnConceal', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorMoved' }, {
	pattern = { '*.md', '*.json' },
	group = conceal,
	desc = 'un-conceal in *.md and *.json files',
	callback = function()
		vim.api.nvim_win_set_option(0, 'conceallevel', 0)
	end,
})

-- strip trailing white spaces and save on 'InsertLeave', 'BufLeave', 'WinLeave', 'CmdlineLeave', 'ExitPre'
local autosave_enabled = true
local autosave_interval = 10 -- ms

local function save_buffer()
	if autosave_enabled and config.buffer.savable() then
		vim.cmd('silent write')
	end
end

local function schedule_autosave()
	if autosave_enabled then
		vim.defer_fn(save_buffer, autosave_interval)
	end
end

local autosave = vim.api.nvim_create_augroup('Autosave', { clear = true })
vim.api.nvim_create_autocmd(
	{ 'InsertLeave', 'BufLeave', 'WinLeave', 'CmdlineLeave', 'ExitPre', 'CursorMoved', 'CmdwinLeave' },
	{
		pattern = { '*' },
		group = autosave,
		desc = 'autosave buffers',
		callback = function()
			schedule_autosave()
		end,
	}
)

