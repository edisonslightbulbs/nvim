-- flag to indicate whether Packer sync is necessary
local run_packer_sync = false

-- check if packer.nvim exists; iff not, clone the repository
local target = config.path.join(vim.fn.stdpath("data"), "site", "pack", "packer", "start", "packer.nvim")

if vim.fn.isdirectory(target) == 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", target })
	vim.api.nvim_command("packadd packer.nvim")
	run_packer_sync = true
end

-- verify packer is setup correctly
local packer_status, packer = pcall(require, "packer")
if not packer_status then
	vim.notify("-- Something went wrong while setting up Packer!")
	return
end

-- plugins
local function pack()
	return packer.startup(function(use)
		-- packer
		use("wbthomason/packer.nvim")

		-- theme
		use("morhetz/gruvbox")
		use("vim-airline/vim-airline")
		use("kyazdani42/nvim-web-devicons")
		use("vim-airline/vim-airline-themes")

		-- extensions
		use("tpope/vim-fugitive")
		use("nvim-lua/plenary.nvim")
		use({ "akinsho/toggleterm.nvim", tag = "v2.*" })
		use("google/vim-searchindex")
		use("dstein64/vim-startuptime")
		use("kyazdani42/nvim-tree.lua")
		use("nvim-telescope/telescope.nvim")

		-- editing/formatting
		use("tpope/vim-repeat")
		use("tpope/vim-surround")
		use("yggdroot/indentline")
		use("raimondi/delimitmate")
		use("stevearc/conform.nvim")

		-- intellisence
		use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
		use("williamboman/nvim-lsp-installer")
		use("rafamadriz/friendly-snippets")
		use("nvim-lua/lsp-status.nvim")
		use("neovim/nvim-lspconfig")
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-nvim-lsp")
		use("onsails/lspkind.nvim")
		use("L3MON4D3/LuaSnip")
	end)
end

-- plugin configuration
local function configure()
	require("plugins.setup.repeat")
	require("plugins.setup.airline")
	require("plugins.setup.fugitive")
	require("plugins.setup.nvimtree")
	require("plugins.setup.telescope")
	require("plugins.setup.indentline")
	require("plugins.setup.treesitter")
	require("plugins.setup.toggleterm")
	require("plugins.setup.lspinstaller")
	require("plugins.setup.lspconfig")
	require("plugins.setup.conform")
	require("plugins.setup.surround")
	require("plugins.setup.luasnip")
	require("plugins.setup.cmp")
	require("plugins.setup.gruvbox")
end

-- pack plugins using packer
local pack_status, pack_message = pcall(pack)
if not pack_status then
	vim.notify("-- Something went wrong while packing plugins!")
	vim.notify(pack_message)
	return
end

-- run packer sync if necessary
if run_packer_sync then
	packer.sync()
end

-- configure plugins
local configure_status, message = pcall(configure)
if not configure_status and message ~= nil then
	vim.notify("-- Something went wrong while setting up plugins!")
	vim.notify(message)
	return
end
