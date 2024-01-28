print("-- setting up toggleterm")

local status, toggleterm = pcall(require, "toggleterm")
if not status then
	print("-- something went wrong while setting up toggleterm!")
	return
end

local function zsh_term()
	local os = vim.loop.os_uname().sysname
	if os == "Linux" then
		return "zsh"
	elseif os == "Windows_NT" then
		return vim.o.shell
	end
end

toggleterm.setup({
	shell = zsh_term(),
	direction = "horizontal",
	hide_numbers = false,
	close_on_exit = false,
	insert_mappings = true,
	start_in_insert = true,
	terminal_mappings = true,
	autochdir = false,
	auto_scroll = false,
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

local toggle = ":ToggleTerm size="
	.. vim.api.nvim_buf_line_count(0) * 0.40
	.. " dir="
	.. config.path.cwd()
	.. " insert_mappings=true direction=horizontal<CR> "
map("n", "<c-o>", toggle, opt)
