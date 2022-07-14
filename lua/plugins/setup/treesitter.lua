local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
	print('-- something went wrong while setting up treesitter!')
	return
end

treesitter.setup({
	ensure_installed = { 'c', 'cpp', 'bash', 'cmake', 'lua', 'make', 'python', 'vim', 'yaml', 'json', 'markdown' },
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
