_G.toggle_numline_style = function()
	if vim.o.relativenumber == true then
		vim.opt.relativenumber = false
    else
		vim.opt.relativenumber = true
	end
end

local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<C-n>', ':lua toggle_numline_style() <CR>', opts)
