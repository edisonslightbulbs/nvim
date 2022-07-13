local status, ret = pcall(require, 'nvim-treesitter.configs')
if not status then
	print('-- something went wrong while setting up treesitter!')
	return
end

require('nvim-treesitter.configs').setup({
	-- parsers
	ensure_installed = { 'c', 'cpp', 'bash', 'cmake', 'lua', 'make', 'python', 'vim', 'yaml', 'json', 'markdown' },
	sync_install = false,

	highlight = {
		enable = true,

		--[[ true will run `:h syntax` and tree-sitter simultaneously
     may slow down editor, and create duplicate highlights ]]
		additional_vim_regex_highlighting = false,
	},
})

-- folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
