vim.api.nvim_create_user_command('GCommit ', function(opts)
	local command = 'Git commit -m ' .. opts.args
	vim.api.nvim_command(command)
end, { nargs = 1, bang = true, desc = 'git commit' })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
map('n', '<leader>gc', ':GCommit ', opts)
map('n', '<leader>gp', ':Git! push <CR>', opts)
