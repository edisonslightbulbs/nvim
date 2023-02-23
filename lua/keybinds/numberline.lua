_G.toggle_numline_style = function()
    if vim.o.relativenumber == true then
        vim.opt.relativenumber = false
    else
        vim.opt.relativenumber = true
    end
end

-- strip trailing white spaces
_G.stripbuf = function()
    print('Stripping trailing white spaces')
    vim.api.nvim_command('%s/\\s\\+$//e')
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<C-n>', ':lua toggle_numline_style() <CR>', opts)
map('n', '<C-s>', ':lua stripbuf() <CR>', opts)
