local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },

  -- navigation
  {
    "kyazdani42/nvim-tree.lua",
    lazy = false,
    config = function()
      require("plugins.nvimtree")
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      require("plugins.telescope")
    end
  },

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm")
    end
  },

  -- git
  "tpope/vim-fugitive",

  -- theme
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    config = function()
      require("plugins.colorschemes.vscode")
    end
  },

  { "vim-airline/vim-airline", lazy = false },

  {
    "vim-airline/vim-airline-themes",
    lazy = false,
    config = function()
      require("plugins.airline")
    end
  },

  { "kyazdani42/nvim-web-devicons", lazy = false },

  -- format
  "raimondi/delimitmate",
  {
    "tpope/vim-surround",
    config = function()
      require("plugins.surround")
    end
  },

  {
    "tpope/vim-repeat",
    config = function()
      require("plugins.repeat")
    end
  },

  {
    "yggdroot/indentline",
    config = function()
      require("plugins.indentline")
    end
  },

  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.conform")
    end
  },

  -- intellisence
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.treesitter")
    end
  },

  {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("plugins.lspinstaller")
    end
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.luasnip")
    end
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end
  },

  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind.nvim",
  "nvim-lua/lsp-status.nvim",
  "rafamadriz/friendly-snippets",

  -- extensions
  "nvim-lua/plenary.nvim",
  "google/vim-searchindex",
  "dstein64/vim-startuptime",
})
