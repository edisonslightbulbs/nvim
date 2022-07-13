local status, null_ls = pcall(require, "null-ls")
if not status then
	print("-- something went wrong while setting up null-ls!")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

null_ls.setup({
	debug = true,
	sources = {
		formatting.stylua,
		diagnostics.stylua,
	},
}
)

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
map("n", "<leader><i>", ":lua vim.lsp.buf.format()<CR>", opts)
