require("nvim-tree").setup(
    {
        view = {
            number = true,
            relativenumber = true,
            adaptive_size = false,
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
                        symlink = "",
                        symlink_open = ""
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
        git = {
            enable = false,
            ignore = false,
            timeout = 1
        }
    }
)

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
map("n", "<leader><Space>", ":NvimTreeToggle<CR>", opts)
