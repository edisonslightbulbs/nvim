local shell = ""
if vim.fn.has("unix") == 1 then
    shell = "/bin/zsh"
elseif vim.fn.has("macunix") == 1 then
    shell = "/usr/bin/zsh"
end

if vim.fn.has("win32") == 1 then
else
    vim.api.nvim_command("let g:floaterm_shell='zsh'")
end

vim.api.nvim_command("let g:floaterm_wintitle=v:false")

-- gruvbox colors
local function gruvbox()
    vim.cmd [[
    let g:terminal_ansi_colors = [
                \'#282828',
                \'#cc241d',
                \'#98971a',
                \'#d79921',
                \'#458588',
                \'#b16286',
                \'#689d6a',
                \'#a89984',
                \'#928374',
                \'#fb4934',
                \'#b8bb26',
                \'#fabd2f',
                \'#83a598',
                \'#d3869b',
                \'#8ec07c',
                \'#ebdbb2']
]]
end

function Floatterm()
    gruvbox()
    vim.api.nvim_command("FloatermNew --height=0.8 --width=0.8 --wintype=floating --name=terminalwin --autoclose=1")
end

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map("n", "<C-o>", ":lua Floatterm()<CR>", opts)
