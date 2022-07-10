local status, ret = pcall(require, "toggleterm")
if not status then
    print("-- something went wrong while setting toggleterm!")
    return
end

local Terminal = require("toggleterm.terminal").Terminal
local zsh = Terminal:new({cmd = "source ~/.zshrc", hidden = true})

-- description
_G.toggle_zsh = function()
    if vim.fn.has("unix") then
        zsh:toggle()
    end
end

require("toggleterm").setup {
    open_mapping = [[<c-o>]],
    direction = "float",
    hide_numbers = true,
    close_on_exit = true,
    terminal_mappings = true,
    --shell = vim.o.shell
    -- shade_filetypes = {},
    -- start_in_insert = false,
    -- insert_mappings = true,
    -- persist_size = true,
    -- persist_mode = true,
}

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- source
