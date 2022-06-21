vim.cmd [[

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


" use zsh
function! TermShell()
    if has('macunix')
        set shell=/bin/zsh
    elseif has('unix')
        set shell=/usr/bin/zsh
    endif
endfunction

" use gruvbox color palette
function! TermColors()
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
endfunc


"" Config
"    Settings for floating term environment
function! Configure()
endfunction


"" CallFloatTerm
"    Call floating window
function! CallFloatTerm()
    call Configure()
    if has('nvim')
        FloatermNew --height=0.8 --width=0.8 --wintype=floating --name=terminalwin
    else
        execute 'vert term'
    endif
endfunction
nnoremap <silent><C-O> :call CallFloatTerm()<CR>


nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>

function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
]]
