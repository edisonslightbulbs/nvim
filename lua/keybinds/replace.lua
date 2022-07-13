vim.cmd([[
function! ReplaceWordFunction(arg)
    let l:view = winsaveview()
    execute '%s/' . expand('<cword>') . '/' . a:arg . '/gc'
    call winrestview(l:view)
endfunction
command! -nargs=* Repword :call ReplaceWordFunction(<f-args>)

function! ReplaceWORDFunction(arg)
    let l:view = winsaveview()
    execute '%s/' . expand('<cWORD>') . '/' . a:arg . '/gc'
    call winrestview(l:view)
endfunction
command! -nargs=* RepWORD :call ReplaceWORDFunction(<f-args>)

nnoremap <Leader>r  :Repword
nnoremap <Leader>R  :RepWORD
]])
