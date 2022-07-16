vim.cmd([[
function! CommitFunction(...)
    execute ':Gwrite'
    silent execute ":Git commit -m \"" . join(a:000) . "\""
endfunction
command! -nargs=* GitCommitMessage :call CommitFunction(<f-args>)

function! PushFunction(...)
    silent execute ':Git! push'
endfunction
command! -nargs=* GitPush :call PushFunction(<f-args>)

nnoremap <Leader>gc :GitCommitMessage
nnoremap <Leader>gp :GitPush<CR>
]])
