local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	print("-- something went wrong while setting up treesitter!")
	return
end

treesitter.setup({
	-- required parsers
	ensure_installed = {
		"c",
		"cpp",
		"bash",
		"cmake",
		"lua",
		"make",
		"python",
		"vim",
		"yaml",
		"json",
		"markdown",
		"vimdoc",
		"query",
	},

	-- install required parsers synchronously
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	ignore_install = {},

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.nofoldenable = "nofoldenable" -- Disable folding at startup.
