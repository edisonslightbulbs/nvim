local status, toggleterm = pcall(require, 'toggleterm')
if not status then
    print('-- something went wrong while setting toggleterm!')
    return
end

local function zsh_term()
    local os = vim.loop.os_uname().sysname
    if os == 'Linux' then
        return 'zsh'
    elseif os == 'Windows_NT' then
        return vim.o.shell
    end
end

toggleterm.setup({
    shell = zsh_term(),
    open_mapping = [[<c-o>]],
    direction = 'float',
    hide_numbers = true,
    close_on_exit = false,
    insert_mappings = true,
    start_in_insert = false,
    terminal_mappings = true,
    -- shade_filetypes = {},
    -- insert_mappings = true,
    -- persist_size = true,
    -- persist_mode = true,
})
