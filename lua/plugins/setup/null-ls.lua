local status, null_ls = pcall(require, 'null-ls')
if not status then
	print('-- something went wrong while setting up null-ls!')
	return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = true,
	sources = {
		formatting.stylua.with({ extra_args = { '--quote-style', 'AutoPreferSingle' } }),
		formatting.autopep8.with({ extra_args = {'--aggressive'}}),
		formatting.clang_format,
		formatting.cmake_format,
		formatting.latexindent,
		formatting.shfmt,
		formatting.fixjson,
		formatting.tidy, --xml
	},
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
map('n', '<leader>i', ':lua vim.lsp.buf.format()<CR>', opts)
