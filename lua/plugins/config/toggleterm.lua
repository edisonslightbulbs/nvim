local status, ret = pcall(require, "toggleterm")
if not status then
    print("-- something went wrong while setting toggleterm!")
    return
end

local function term()
    if vim.fn.has("unix") then
        return "zsh"
    end
    return ""
end

require("toggleterm").setup {
    shell = term(),
    open_mapping = [[<c-o>]],
    direction = "float",
    hide_numbers = true,
    close_on_exit = true,
    insert_mappings = true,
    terminal_mappings = true
    -- shade_filetypes = {},
    -- start_in_insert = false,
    -- insert_mappings = true,
    -- persist_size = true,
    -- persist_mode = true,
}
