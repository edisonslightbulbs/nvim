let NERDTreeMouseMode=2
let NERDTreeHighlightCursorline=1

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]



"  You can use the BufDelete autocmd to trigger code automatically when a
"  buffer is deleted. Have it call a function that checks the number of open
"  buffers (e.g. for loop to bufnr("$") checking
"  bufexists()/buflisted()/bufloaded() or whatever you're considering "open"
"  to be. If you find only one buffer - that's the one that's about to close.
"  :q away.


" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

function! IsLastBuff()
    let l:bufcount = len(getbufinfo({'buflisted':1}))
    if l:bufcount == 1
        return v:true
    else
        return v:false
    endif
endfunction

"resolving: E444: Cannot close last window
function! CheckLastWindow()
    " Iff NERDTree window is the last remaining
    " window and  no other buffers are listed,
    " delete the nerdtree buffer
    if &filetype ==#'nerdtree' && winnr('$') == 1
        if len(getbufinfo({'buflisted':1})) == 1
            execute 'bd'
        else
            execute 'bn'
        endif
    else
        call ToggleNTree()
    endif

endfunction

function! ToggleNTree()
    execute 'NERDTreeToggle .'
    if &number != 1
        set relativenumber
        set number
        set number relativenumber
    endif
endfunction

function! SmartToggle()
    call CheckLastWindow()
endfunction

nnoremap <silent><Leader><Space> :call CheckLastWindow()<CR>


