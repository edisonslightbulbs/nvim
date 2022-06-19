-- aliases
local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


--setup
require("nvim-tree").setup({
    update_cwd = true,
    sort_by = "case_sensitive",
    hijack_unnamed_buffer_when_opening = true,

    view = {
        number = true,
        relativenumber = true,
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
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
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "",
                    untracked = "",
                    deleted = "",
                    ignored = "",
                },
            },
        },
    },

    --
    filters = {
        dotfiles = false,
    },

    --
    update_focused_file = {
        enable = true,
        update_cwd = true,
        update_root = true,
        ignore_list = {},
    },
})


-- key mapping/s
map('n', '<leader>t', ':NvimTreeToggle<CR>', opts) -- toggle
