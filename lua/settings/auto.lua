local startup = vim.api.nvim_create_augroup('Startup', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
	pattern = '',
	group = startup,
	desc = 'all systems go',
	callback = function()
		print('Now then, lets get started, shall we?')
	end,
})

local autoread = vim.api.nvim_create_augroup('Reload', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter' }, {
	pattern = '*',
	group = autoread,
	desc = 'reloads buf if file modified outside nvim',
	callback = function()
		vim.api.nvim_command('checktime')
	end,
})

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

local conceal = vim.api.nvim_create_augroup('UnConceal', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	pattern = { '*.md', '*.json' },
	group = conceal,
	desc = 'un-conceal in *.md and *.json files',
	callback = function()
		vim.opt.conceallevel=0
	end,
})
