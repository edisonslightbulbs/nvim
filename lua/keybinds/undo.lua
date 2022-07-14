vim.cmd([[
function! Undo()
    let l:view = winsaveview()
    execute ':undo'
    execute ':Autoformat'
    call winrestview(l:view)
endfunction
map('n', '<leader>u', ':call Undo()<CR>', opts)       -- write buffer
]])
