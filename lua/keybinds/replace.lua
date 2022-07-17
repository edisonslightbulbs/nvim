vim.api.nvim_create_user_command('ReplaceWord ', function(opts)
	local view = vim.fn.winsaveview()
	local word_under_cursor = vim.call('expand', '<cword>')
	local command = '%s/' .. word_under_cursor .. '/' .. opts.args .. '/gc'

	vim.api.nvim_command(command)
	vim.fn.winrestview(view)
end, { nargs = 1, bang = true, desc = 'replace in word' })

vim.api.nvim_create_user_command('ReplaceWORD ', function(opts)
	local view = vim.fn.winsaveview()
	local word_under_cursor = vim.call('expand', '<cWORD>')
	local command = '%s/' .. word_under_cursor .. '/' .. opts.args .. '/gc'

	vim.api.nvim_command(command)
	vim.fn.winrestview(view)
end, { nargs = 1, bang = true, desc = 'replace in word' })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
map('n', '<leader>r', ':ReplaceWord ', opts)
map('n', '<leader>R', ':ReplaceWORD ', opts)
