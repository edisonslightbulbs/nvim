local status, ret = pcall(require, "telescope")
if not status then
    print("-- something went wrong while setting up telescope!")
    return
end

require("telescope").setup {}

local telescope_opts = {
    cwd = git_root(),
    file_ignore_patterns = {
        "^.git/",
        "^build/",
        "%.metainfo",
        "^autosave/",
        "^deprecated/"
    },
    hidden = true,
    no_ignore = true
}

_G.telescope_live_grep = function()
    require("telescope.builtin").live_grep(telescope_opts)
end

_G.telescope_find_files = function()
    require("telescope.builtin").find_files(telescope_opts)
end

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map("n", "tg", ":lua telescope_live_grep()<CR>", opts)
map("n", "tf", ":lua telescope_find_files()<CR>", opts)
