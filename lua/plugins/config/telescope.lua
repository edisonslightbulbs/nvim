-- aliases
local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<leader><Space>', ':Telescope git_files <CR>', opts) -- pull up telescope
--map('n', '<leader>', ':Telescope find_files <CR>', opts) -- pull up telescope
