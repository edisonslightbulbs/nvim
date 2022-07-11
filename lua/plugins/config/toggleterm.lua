local status, ret = pcall(require, "toggleterm")
if not status then
    print("-- something went wrong while setting toggleterm!")
    return
end

require("toggleterm").setup {
    open_mapping = [[<c-o>]],
    direction = "float",
    hide_numbers = true,
    close_on_exit = true,
    insert_mappings = true,
    terminal_mappings = true,
    shell = "zsh"
    -- shade_filetypes = {},
    -- start_in_insert = false,
    -- insert_mappings = true,
    -- persist_size = true,
    -- persist_mode = true,
}
