local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = false }
local opts = { noremap = true, silent = true }

-- leader
vim.g.mapleader = ";"

-- source
map("n", "<space>5", ':source % | echo bufname() "sourced successfully"<CR>', opt)

-- yanking
map("", "<leader><ENTER>", '"k', opts) -- yank into k (all modes)

-- searching
map("n", "<leader>;", ";", opts) -- repeat find-in-line
map("n", "<leader>c", ':let @/=""<CR>', opts) -- clear search highlight
map("n", "#", ":keepjumps normal! mi*`i<CR>", opts) -- swap # and *, hold cursor position

-- window managing
map("n", "<leader>q", ":q!<CR>", opts) -- quit window

map("n", "+", ":vertical resize +25<CR>", opts) -- re-size v-window +25
map("n", "_", ":vertical resize -25<CR>", opts) -- re-size v-window -25
map("n", "[", ":horizontal resize +25<CR>", opts) -- re-size h-window +25
map("n", "]", ":horizontal resize -25<CR>", opts) -- re-size h-window -25

-- window navigation
map("n", "<C-J>", "<C-W><C-J>", opts) -- to bottom window
map("n", "<C-K>", "<C-W><C-K>", opts) -- to top window
map("n", "<C-H>", "<C-W><C-H>", opts) -- to left window
map("n", "<C-L>", "<C-W><C-L>", opts) -- to right window


-- use :v instead of :vertical
vim.cmd("cnoreabbrev v vertical")

require("keybinds.buffer")
require("keybinds.replace")
require("keybinds.numberline")
