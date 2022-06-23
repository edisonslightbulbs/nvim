local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- leader
vim.g.mapleader = ';'

-- source
map('n', '<leader>%', ':source % <CR>', opts)      -- source current file

-- yanking
map('n', '<leader><ENTER>', '"k', opts)             -- yank into k

-- searching
map('n', '<leader>;', ';',  opts)                  -- repeat find-in-line
map('n', '<leader>c', ':let @/=""<CR>', opts)      -- clear search highlight
map('n', '#', ':keepjumps normal! mi*`i<CR>', opts)-- swap # and *, hold cursor position


-- window managing
map('n', '<leader>q', ':q!<CR>', opts)             -- quit window
map('n', '<leader>|', ':vnew<CR>', opts)           -- create new v-window
map('n', '<leader>\\', ':new<CR>', opts)           -- create new h-window

map('n', '+', ':vertical resize +25<CR>', opts)    -- re-size v-window +25
map('n', '_', ':vertical resize -25<CR>', opts)    -- re-size v-window -25
map('n', '[', ':horizontal resize +25<CR>', opts)  -- re-size h-window +25
map('n', ']', ':horizontal resize +25<CR>', opts)  -- re-size h-window -25


-- window navigation
map('n', '<C-J>', '<C-W><C-J>', opts)              -- to bottom window
map('n', '<C-K>', '<C-W><C-K>', opts)              -- to top window
map('n', '<C-H>', '<C-W><C-H>', opts)              -- to left window
map('n', '<C-L>', '<C-W><C-L>', opts)              -- to right window



require('keybindings.undo')
require('keybindings.buffer')
require('keybindings.replace')
require('keybindings.numberline')
