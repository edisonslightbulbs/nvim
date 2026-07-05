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
    "folke/neodev.nvim",                            -- Lua configuration for Neovim
    "folke/which-key.nvim",                         -- Display possible keybindings
    { "folke/neoconf.nvim",      cmd = "Neoconf" }, -- Configuration GUI for Neovim

    -- theme
    {
        "Mofiqul/vscode.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.colorschemes.vscode")
        end
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        priority = 900,
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    },

    {
        "echasnovski/mini.nvim",
        version = false,
        config = function()
            require("mini.icons").setup()
        end,
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
        "nvim-tree/nvim-tree.lua", -- File explorer
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("plugins.nvimtree")
        end
    },
    {
        "nvim-telescope/telescope.nvim", -- Fuzzy finder
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugins.telescope")
        end
    },

    -- terminal integration
    {
        "akinsho/toggleterm.nvim", -- Toggle terminal in Neovim
        config = function()
            require("plugins.toggleterm")
        end
    },

    -- git
    "tpope/vim-fugitive", -- Git integration

    -- formatting and editing
    {
        "stevearc/conform.nvim", -- Autoformatting support
        config = function()
            require("plugins.conform")
        end
    },
    "tpope/vim-surround",   -- Easy manipulation of surrounding characters
    "tpope/vim-repeat",     -- Enable repeating supported plugin commands with "."
    "yggdroot/indentline",  -- Show indentation guides
    "raimondi/delimitmate", -- Autocompletion for delimiters like brackets

    -- intellisense and LSP (Language Server Protocol)
    {
        "nvim-treesitter/nvim-treesitter", -- Syntax highlighting
        config = function()
            require("plugins.treesitter")
        end
    },

    -- markdown rendering
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            file_types = { "markdown", "codecompanion" },
            heading = {
                sign = false,
                icons = {},
            },
        },
    },

    -- local model support
    {
        "olimorris/codecompanion.nvim",
        version = "^19.0.0",
        cmd = {
            "CodeCompanion",
            "CodeCompanionActions",
            "CodeCompanionChat",
            "CodeCompanionCmd",
        },

        -- ;ac  toggle AI chat as floating window
        -- ;ab  ask about current buffer
        -- ;ai  inline ask about current buffer
        -- ;ae  explain selected code
        -- ;af  fix selected code
        -- ;at  generate tests for selected code
        -- ;aa  action palette, fallback only
        keys = {
            {
                "<leader>ac",
                function()
                    require("codecompanion").toggle({
                        window_opts = {
                            layout = "float",
                            width = 0.85,
                            height = 0.85,
                        },
                    })
                end,
                mode = { "n", "x" },
                desc = "ai chat",
            },
            {
                "<leader>ab",
                function()
                    vim.ui.input({ prompt = "AI buffer: " }, function(input)
                        if not input or input == "" then
                            return
                        end

                        vim.api.nvim_cmd({
                            cmd = "CodeCompanionChat",
                            args = { "#{buffer} " .. input },
                        }, {})
                    end)
                end,
                mode = "n",
                desc = "ai buffer chat",
            },
            {
                "<leader>ai",
                function()
                    vim.ui.input({ prompt = "AI inline: " }, function(input)
                        if not input or input == "" then
                            return
                        end

                        vim.api.nvim_cmd({
                            cmd = "CodeCompanion",
                            args = { "#{buffer} " .. input },
                        }, {})
                    end)
                end,
                mode = "n",
                desc = "ai inline",
            },
            {
                "<leader>ae",
                ":'<,'>CodeCompanion /explain<CR>",
                mode = "x",
                desc = "ai explain selection",
            },
            {
                "<leader>af",
                ":'<,'>CodeCompanion /fix<CR>",
                mode = "x",
                desc = "ai fix selection",
            },
            {
                "<leader>at",
                ":'<,'>CodeCompanion /tests<CR>",
                mode = "x",
                desc = "ai tests selection",
            },
            {
                "<leader>aa",
                "<cmd>CodeCompanionActions<CR>",
                mode = { "n", "x" },
                desc = "ai actions",
            },
        },

        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            adapters = {
                http = {
                    opts = {
                        show_model_choices = false,
                    },
                    ollama = function()
                        return require("codecompanion.adapters").extend("ollama", {
                            schema = {
                                model = {
                                    default = "qwen2.5-coder:14b",
                                },
                            },
                        })
                    end,
                },
            },
            interactions = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
                cmd = {
                    adapter = "ollama",
                },
            },
        },
    },

    -- Mason core
    { "williamboman/mason.nvim", config = true },

    -- Mason → LSP bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        version = "^1.1.0",
        config = function()
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = { "clangd", "pyright", "lua_ls", "jsonls", "texlab", "cmake" },
            })
        end,
    },

    -- install missing tools on startup
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "autopep8",
                    "stylua",
                    "clang-format",
                    "cmakelang",
                    "yamlfmt",
                },
                run_on_start = true,
                start_delay = 3000,
                debounce_hours = 24,
            })
        end,
    },

    -- Core LSP config
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("plugins.lspconfig")
        end
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip", -- Snippet engine
        config = function()
            require("plugins.luasnip")
        end
    },

    -- Autocompletion engine
    {
        "hrsh7th/nvim-cmp",         -- Autocompletion
        dependencies = {
            "hrsh7th/cmp-path",     -- Completion for file paths
            "hrsh7th/cmp-buffer",   -- Completion for text within buffers
            "hrsh7th/cmp-cmdline",  -- Completion for command line
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
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
                    right_margin  = 1, -- keep one space after =
                    ignore_groups = { "String", "Comment" },
                },
            }
        end,
    },

    -- LSP and completion extensions
    "onsails/lspkind.nvim",         -- Adds icons to completion
    "nvim-lua/lsp-status.nvim",     -- LSP status in the status line
    "rafamadriz/friendly-snippets", -- Predefined snippets for various languages

    -- Lua utilities
    "dstein64/vim-startuptime", -- Measure startup time
})
