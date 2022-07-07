-- aliases
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

require("nvim-tree").setup(
    {
        view = {
            number = true,
            relativenumber = true,
            adaptive_size = true,
            mappings = {
                list = {
                    {key = "u", action = "dir_up"}
                }
            }
        },
        renderer = {
            group_empty = true,
            icons = {
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = ""
                    },
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "",
                        untracked = "",
                        deleted = "",
                        ignored = ""
                    }
                }
            }
        },
        filters = {
            dotfiles = false,
            exclude = {"*.metainfo", "*.py.lock"},
            custom = {"autoload", "spell"}
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            update_root = true,
            ignore_list = {}
        },
        git = {
            enable = false,
            ignore = false,
            timeout = 1
        }
    }
)

map("n", "<leader><Space>", ":NvimTreeToggle<CR>", opts)
