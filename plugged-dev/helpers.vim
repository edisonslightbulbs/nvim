" author: Everett
" created: 2020-08-13 11:22
" Github: https://github.com/antiqueeverett/
" toggle number line style


function! ToggleNumLineStyle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
        set number
        set number relativenumber
    endif
endfunction

" toggle line numbers on/off
function! ToggleNumLine()
    if &relativenumber == 1 || &number == 1
        set norelativenumber
        set nonumber
    else
        set relativenumber
        set number
        set number relativenumber
    endif
endfunction

" key maps
nnoremap <silent><C-N> :call ToggleNumLine()<CR>
nnoremap <silent><Leader>? :call ToggleNumLineStyle()<CR>

""
" IsLastWindow:
"   Checks if current window
"   is the last window
function! IsLastWindow()
    if winnr() == winnr('$')
        return v:true
    else
        return v:false
    endif
endfunction

""
" IsLastBuffer:
"   Verifies current buffer is last buffer
function! IsLastBuffer()
    let l:buffer_count = 0
    for i in range(0, bufnr('$'))
        if buflisted(i)
            let l:buffer_count = l:buffer_count + 1
        endif
    endfor

    if l:buffer_count == 1
        return v:true
    else
        return v:false
    endif
endfunction

""
" ExitVim:
"   Exits vim iff current buffer is
"   last buffer and not a working buffer.
" todo: test!!!
" date: 2020-08-13 11:56
function! ExitVim()
    if IsLastBuffer()
        if IsLastWindow()
            silent execute '!clear'
            silent execute 'q!'
        else
            close!
        endif
    endif
endfunction

