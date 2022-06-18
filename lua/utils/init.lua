vim.cmd [[
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

"" MuttMail
"    Open Mutt in floating window
function! MuttMail()
    call Configure()
    if has('nvim')
        FloatermNew --height=0.8 --width=0.8 --wintype=floating --name=emailwin neomutt
    else
        set termwinsize=0x86
        vert term neomutt
    endif
endfunction

"" AsyncTex
"    Execute Tex build asynchronously
function! AsyncTex()
    copen 40
    AsyncRun time tex.sh main.tex
endfunction

"" AsyncCMake
"    Execute CMake build asynchronously
function! AsyncCMake()
    copen 40
    AsyncRun cmake.sh -j 10
endfunction


"" Key maps
"" nnoremap <silent><Leader>2 :call AsyncTex()<CR>
"" nnoremap <silent><Leader>1 :call AsyncCMake()<CR>

" nnoremap <silent><Leader>M :call MuttMail()<CR>

nnoremap <silent><C-O> :call CallFloatTerm()<CR>



]]

