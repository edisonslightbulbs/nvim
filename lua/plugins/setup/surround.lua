local map = vim.api.nvim_set_keymap
local opts = { noremap = false, silent = false }

map('n', '<space>w', 'ysiw', opts)
map('n', '<space>W', 'ysiW', opts)
