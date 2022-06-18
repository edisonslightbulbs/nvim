-- leader
vim.g.mapleader = ';'

-- aliases
local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


-- searching
map('n', '<leader>;', ';',  opts)                  -- repeat find-in-line
map('n', '<leader>c', ':let @/=""<CR>', opts)      -- clear search highlight

--  " swap # and * & search from word under cursor
--  nnoremap # :keepjumps normal! mi*`i<CR>


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


-- buffer manipulation
map('n', '<leader>0', ':edit!', opts)              -- reload buffer << @todo: make auto >>
map('n', '<leader>d', ':bd<CR>', opts)             -- delete buffer
map('n', '<leader><Tab>', ':bN<CR>', opts)         -- next buffer
map('n', '<leader><S-Tab>', ':bn<CR>', opts)       -- previous buffer
map('n', '<leader><ENTER>', ':w<CR>', opts)        -- write buffer
