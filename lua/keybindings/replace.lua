vim.cmd [[
function! ReplaceWordFunction(arg)
    execute '%s/' . expand('<cword>') . '/' . a:arg . '/gc'
endfunction
command! -nargs=* Repword :call ReplaceWordFunction(<f-args>)

function! ReplaceWORDFunction(arg)
    execute '%s/' . expand('<cWORD>') . '/' . a:arg . '/gc'
endfunction
command! -nargs=* RepWORD :call ReplaceWORDFunction(<f-args>)

nnoremap <Leader>r  :Repword
nnoremap <Leader>R  :RepWORD 
]]
