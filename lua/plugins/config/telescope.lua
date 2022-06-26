local status, ret = pcall(require, "telescope")
if not status then
    print("-- something went wrong while setting up telescope!")
    return
end

require('telescope').setup{ }

local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--map('n', '<leader><Space>', ':Telescope git_files <CR>', opts) -- pull up telescope
--map('n', '<leader>', ':Telescope find_files <CR>', opts) -- pull up telescope
--map('n', '<leader><Space>', '<cmd>lua require("telescope.builtin").find_files({ no_ignore = true })<CR>', opts)
map('n', '<leader><Space>', '<cmd>lua require("telescope.builtin").git_files({ no_ignore = true })<CR>', opts)
