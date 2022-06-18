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
