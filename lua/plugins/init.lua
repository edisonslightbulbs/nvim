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
  -- enhancements
  "folke/neodev.nvim",  -- Lua configuration for Neovim
  "folke/which-key.nvim",  -- Display possible keybindings
  { "folke/neoconf.nvim", cmd = "Neoconf" },  -- Configuration GUI for Neovim

  -- theme
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("plugins.colorschemes.vscode")
    end
  },

  -- status line and airline
  {
    "vim-airline/vim-airline",
    dependencies = {
      "google/vim-searchindex",
      "nvim-tree/nvim-web-devicons",
      "vim-airline/vim-airline-themes",
    },
    config = function()
      require("plugins.airline")
    end
  },

  -- navigation
  {
    "nvim-tree/nvim-tree.lua",  -- File explorer
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.nvimtree")
    end
  },
  {
    "nvim-telescope/telescope.nvim",  -- Fuzzy finder
    config = function()
      require("plugins.telescope")
    end
  },

  -- terminal integration
  {
    "akinsho/toggleterm.nvim",  -- Toggle terminal in Neovim
    config = function()
      require("plugins.toggleterm")
    end
  },

  -- git
  "tpope/vim-fugitive",  -- Git integration

  -- formatting and editing
  {
    "stevearc/conform.nvim",  -- Autoformatting support
    config = function()
      require("plugins.conform")
    end
  },
  "tpope/vim-surround",  -- Easy manipulation of surrounding characters
  "tpope/vim-repeat",  -- Enable repeating supported plugin commands with "."
  "yggdroot/indentline",  -- Show indentation guides
  "raimondi/delimitmate",  -- Autocompletion for delimiters like brackets

  -- intellisense and LSP (Language Server Protocol)
  {
    "nvim-treesitter/nvim-treesitter",  -- Syntax highlighting
    config = function()
      require("plugins.treesitter")
    end
  },

  -- Mason core
  { "williamboman/mason.nvim", config = true },

  -- Mason → LSP bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = { "clangd", "pyright", "lua_ls", "jsonls", "texlab", "cmake" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",  -- Core LSP configurations
    dependencies = {                   -- make sure these load first
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",          -- for capabilities
    },
    config = function()
      require("plugins.lspconfig")
    end
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",  -- Snippet engine
    config = function()
      require("plugins.luasnip")
    end
  },

  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",  -- Autocompletion
    dependencies = {
      "hrsh7th/cmp-path",  -- Completion for file paths
      "hrsh7th/cmp-buffer",  -- Completion for text within buffers
      "hrsh7th/cmp-cmdline",  -- Completion for command line
      "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
    },
    config = function()
      require("plugins.cmp")
    end
  },

  -- editing / text-objects / alignment
  {
    "junegunn/vim-easy-align",
    lazy = false,
    keys = {
      -- start EasyAlign in either mode with `ga`
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } },
    },
    init = function()
      -- optional: tweak how the "=" delimiter behaves
      vim.g.easy_align_delimiters = {
        ["="] = {
          pattern       = "=",
          left_margin   = 0,
          right_margin  = 1,    -- keep one space after =
          ignore_groups = { "String", "Comment" },
        },
      }
    end,
  },

  -- LSP and completion extensions
  "onsails/lspkind.nvim",  -- Adds icons to completion
  "nvim-lua/lsp-status.nvim",  -- LSP status in the status line
  "rafamadriz/friendly-snippets",  -- Predefined snippets for various languages

  -- Lua utilities
  "nvim-lua/plenary.nvim",  -- Utility functions for Neovim plugins
  "dstein64/vim-startuptime",  -- Measure startup time
})
