local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.cmd[[
function! BuffNav()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        let buff = bufname('')
        execute ':bN'
        execute ':bd ' . buff
        echo  buff . ' closed'
    endif
endfunction
]]

map('n', '<S-Tab>', ':bN<CR>', opts)               -- previous buffer
map('n', '<leader>0', ':edit!', opts)              -- reload buffer << @todo: make auto >>
map('n', '<leader><Tab>', ':bn<CR>', opts)         -- next buffer
map('n', '<leader>d', ':call BuffNav()<CR>', opts) -- delete buffer