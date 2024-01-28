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

_G.config.filetypes = {"lua", "cpp", "h", "hpp", "py", "json"}

require("lazy").setup({
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },

  -- theme
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    config = function()
      require("plugins.colorschemes.vscode")
    end
  },

  { "vim-airline/vim-airline", 
  lazy = false,

    dependencies = {
    "google/vim-searchindex",
    "kyazdani42/nvim-web-devicons",
    "vim-airline/vim-airline-themes",
    },

    config = function()
      require("plugins.airline")
    end

  },

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
    lazy = true,
    config = function()
      require("plugins.toggleterm")
    end
  },

  -- git
  "tpope/vim-fugitive",


  -- format
  {
    "stevearc/conform.nvim",
    lazy = true, 
    ft = config.filetypes,
    config = function()
      require("plugins.conform")
    end
  },

  {
    "tpope/vim-surround",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("plugins.surround")
    end
  },

  {
    "tpope/vim-repeat",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("plugins.repeat")
    end
  },

  {
    "yggdroot/indentline",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("plugins.indentline")
    end
  },

  "raimondi/delimitmate",

  -- intellisence
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("plugins.treesitter")
    end
  },

  {
    "williamboman/nvim-lsp-installer",
    lazy = true, 
    ft = config.filetypes,
    config = function()
      require("plugins.lspinstaller")
    end
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true, 
    ft = config.filetypes,
    config = function()
      require("plugins.lspconfig")
    end
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = true, 
    ft = config.filetypes,
    config = function()
      require("plugins.luasnip")
    end
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.cmp")
    end
  },

  "onsails/lspkind.nvim",
  "nvim-lua/lsp-status.nvim",
  "rafamadriz/friendly-snippets",

  -- extensions
  "nvim-lua/plenary.nvim",
  "dstein64/vim-startuptime",
})
