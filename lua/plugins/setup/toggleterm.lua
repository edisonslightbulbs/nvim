local status, toggleterm = pcall(require, 'toggleterm')
if not status then
	print('-- something went wrong while setting up toggleterm!')
	return
end

local function zsh_term()
	local os = vim.loop.os_uname().sysname
	if os == 'Linux' then
		return 'zsh'
	elseif os == 'Windows_NT' then
		return vim.o.shell
	end
end

toggleterm.setup({
	shell = zsh_term(),
	direction = 'float',
	hide_numbers = true,
	close_on_exit = false,
	insert_mappings = true,
	start_in_insert = false,
	terminal_mappings = true,
})

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

local toggle = ':ToggleTerm size=40 dir=' .. bufdir() .. ' direction=float<CR>'
map('n', '<c-o>', toggle, opt)
