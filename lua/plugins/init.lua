local function plug()
	return require('packer').startup(function(use)
		-- packer
		use('wbthomason/packer.nvim')

		-- theme
		use('morhetz/gruvbox')
		use('vim-airline/vim-airline')
		use('kyazdani42/nvim-web-devicons')
		use('vim-airline/vim-airline-themes')

		-- extensions
		use('ervandew/supertab')
		use('tpope/vim-fugitive')
		use('nvim-lua/plenary.nvim')
		use({ 'akinsho/toggleterm.nvim', tag = 'v2.*' })
		use('google/vim-searchindex')
		use('dstein64/vim-startuptime')
		use('kyazdani42/nvim-tree.lua')
		use('nvim-telescope/telescope.nvim')

		-- editing/formatting
		use('tpope/vim-repeat')
		use('tpope/vim-surround')
		use('yggdroot/indentline')
		use('raimondi/delimitmate')
		use('jose-elias-alvarez/null-ls.nvim')

		-- intellisence
		use('nvim-treesitter/nvim-treesitter')
		use('williamboman/nvim-lsp-installer')
		use('rafamadriz/friendly-snippets')
		use('neovim/nvim-lspconfig')
		use('hrsh7th/nvim-cmp')
		use('hrsh7th/cmp-path')
		use('hrsh7th/cmp-buffer')
		use('hrsh7th/cmp-cmdline')
		use('hrsh7th/cmp-nvim-lsp')
		use('onsails/lspkind.nvim')
		use('L3MON4D3/LuaSnip')
	end)
end

local function setup()
	--[[ For each plugin-setup module (listed below):
    Use pcalls (protected calls) to verify plugin state before
    executing setup commands. The pcalls run un-interrupted. If
    a plugin's state is erroneous setup is not executed. ]]
	require('plugins.custom.smart-buf')
	require('plugins.custom.autosave')
	require('plugins.setup.repeat')
	require('plugins.setup.airline')
	require('plugins.setup.fugitive')
	require('plugins.setup.nvimtree')
	require('plugins.setup.telescope')
	require('plugins.setup.indentline')
	require('plugins.setup.treesitter')
	require('plugins.setup.toggleterm')
	require('plugins.setup.lspinstaller')
	require('plugins.setup.lspconfig')
	require('plugins.setup.supertab')
	require('plugins.setup.surround')
	require('plugins.setup.luasnip')
	require('plugins.setup.null-ls')
	require('plugins.setup.cmp')
end

local sync = false
local target = join_path(vim.fn.stdpath('data'), 'site', 'pack', 'packer', 'start', 'packer.nvim')

if vim.fn.isdirectory(target) == 0 then
	vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', target })
	sync = true
end

plug()
if sync then
	require('packer').sync()
end
setup()
