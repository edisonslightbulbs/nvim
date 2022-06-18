" use dir of working buffer
augroup to_buff_dir
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
augroup END

" silence pesky read only for git diff
augroup noro_in_diff
    autocmd!
    autocmd BufEnter * if &diff | set noro |endif
augroup END

" allow external file updates
augroup check_ext_buff_changes
    autocmd!
    autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
augroup END

" allow external file updates
" augroup update_ext_buff_changes
"     autocmd!
"     autocmd BufEnter * silent! execute 'edit!'
" augroup END

" trim white spaces:
augroup strip_white_spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" initially hide git-gutter signs:
augroup hide_signs
    autocmd!
    autocmd BufRead * silent execute 'GitGutterSignsDisable'
augroup END

" line wrapping:
" augroup wrap_lines
"     autocmd!
"     autocmd BufRead,BufNewFile * setlocal textwidth=80
" augroup END

" color scheme overrides:
augroup set_colors
    autocmd!
    " background and font
    autocmd ColorScheme * highlight Normal
                \ term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
                \ gui=NONE guibg=#1d2021 guifg=#abb2b9

    " cursor line
    autocmd ColorScheme * highlight CursorLine
                \ term=NONE cterm=underline ctermbg=NONE ctermfg=NONE
                \ gui=NONE guibg=black  guifg=NONE

    " cursor line number
    autocmd ColorScheme * highlight CursorLineNr
                \ term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
                \ gui=NONE guibg=#1d2021 guifg=White

    " number line
    autocmd ColorScheme * highlight LineNr
                \ term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
                \ gui=NONE guibg=#1d2021 guifg=#808b96

    " popup menu
    autocmd ColorScheme * highlight Menu
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1c2833 guifg=#eaecee

    autocmd ColorScheme * highlight Pmenu
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1c2833 guifg=#eaecee

    autocmd ColorScheme * highlight PmenuSel
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#eaecee guifg=#1c2833

    autocmd ColorScheme * highlight PmenuSbar
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1c2833 guifg=#eaecee

    autocmd ColorScheme * highlight PmenuThumb
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1c2833 guifg=#eaecee

    " sign gutter
    autocmd ColorScheme * highlight SignColumn
                \ term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
                \ gui=NONE guibg=#21262c guifg=NONE

    " wrapping column
    autocmd ColorScheme * highlight ColorColumn
                \ term=NONE cterm=NONE ctermbg=NONE ctermfg=NONE
                \ gui=NONE guibg=#21262c guifg=NONE

    " spellings
    autocmd ColorScheme * highlight SpellBad
                \ term=bold cterm=underline,bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1d2021 guifg=#8f3f71

    autocmd ColorScheme * highlight SpellCap
                \ term=bold cterm=underline,bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1d2021 guifg=#8f3f71

    autocmd ColorScheme * highlight SpellLocal
                \ term=bold cterm=underline,bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1d2021 guifg=#8f3f71

    autocmd ColorScheme * highlight SpellRare
                \ term=bold cterm=underline,bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#1d2021 guifg=#8f3f71

    " search
    autocmd ColorScheme * highlight Search
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#F6D55C guifg=black

    " incremental search
    autocmd ColorScheme * highlight IncSearch
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#F6D55C guifg=black

    " visual
    autocmd ColorScheme * highlight Visual
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#f8f5d7 guifg=#1c2833

    " vertical split
    autocmd ColorScheme * highlight VertSplit
                \ term=bold cterm=bold ctermbg=NONE ctermfg=NONE
                \ gui=bold guibg=#21262c guifg=#5a5c5d

    " todo: incremental improvements from this
    "       point downwards
    " date: 2020-08-14 09:25
    " parenthesis
    autocmd ColorScheme * highlight MatchParen   guibg=Black guifg=White

    " status line
    autocmd ColorScheme * highlight StatusLine   guibg=Black guifg=Grey

    " tab line
    autocmd ColorScheme * highlight TabLine      guibg=White guifg=Grey
    autocmd ColorScheme * highlight TabLineFill  guibg=White guifg=Grey
    autocmd ColorScheme * highlight TabLineSel   guibg=White guifg=Grey


    "  " cursor
    "  autocmd ColorScheme * highlight Cursor
    "              \ term=NONE cterm=underline ctermbg=NONE ctermfg=NONE
    "              \ gui=NONE guibg=red  guifg=white

    "  " cursor
    "  autocmd ColorScheme * highlight iCursor
    "              \ term=NONE cterm=underline ctermbg=NONE ctermfg=NONE
    "              \ gui=NONE guibg=red  guifg=white

augroup END
