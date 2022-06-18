vim.cmd [[


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-autosave.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"option: uses command heightt of 2 (for convenience) vs silence
" autoevent is triggered allong with toher events .....and event messgs ....

if exists('g:load_autosave') | finish | endif
let g:load_autosave = 1
""
" Writable:
"     Checks if current buffer is writable.
function! Writable()
    if &modifiable==#'1' && &buftype==#'' && &filetype !=#''
        return v:true
    elseif &modifiable!=#'1' || &buftype!=#'' || &filetype ==#''
        return v:false
    endif
endfunction

""
" IsNERDTree:
"     Checks if current buffer is a NERDTREE buffer.
function! IsNERDTree()
    if  &filetype ==#'nerdtree'
        return v:true
    else
        return v:false
    endif
endfunction

""
" IsNoName:
"   Checks if current buffer is a No Name buffer.
function! IsNoName()
    if &buftype==#'' && bufname('%')==#'' && &modifiable==#'1'
        return v:true
    else
        return v:false
    endif
endfunction

""
" Savable:
"   Checks if current buffer is a working buffer.
function! Savable()
    if Writable() && !IsNERDTree()
        if !IsNoName()
            return v:true
        endif
    else
        return v:false
    endif
endfunction

""
" AutoSave:
"   Persist :write
function! AutoSave()
    if Savable() && g:load_autosave ==1
        silent! execute 'write'
    endif
endfunction

" VIM_AUTOSAVE CASES:
"   case 1: after text is changed in normal mode [ TextChanged ]
"   case 2: when leaving insert mode [ InsertLeave ]
"   case 3: before leaving a buffer [ BufLeave ]
"   case 4: before exiting vim [ VimLeavePre ]
augroup vim_autosave_au
    autocmd!
    autocmd TextChanged,InsertLeave,BufLeave,VimLeavePre * :call AutoSave()
augroup END

""
" AutoSave:
"   Persist :write
" function! UpdateBuffer()
"     if Savable()
"         silent! execute 'edit!'
"     endif
" endfunction

" update buffer with external file changes
" augroup update_ext_buff_changes
"     autocmd!
"     autocmd BufEnter,BufLeave, * :call UpdateBuffer()
" augroup END


""
" DisableAutoSave:
"     Disables autosave.
function! DisableAutoSave()
    if &readonly
        let g:load_autosave = 0
        set nobackup
        set noswapfile
        set noundofile
    endif
endfunction

augroup readonly
    autocmd!
    autocmd BufReadPost * : call DisableAutoSave()
augroup END





""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-undo.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('g:loaded_undo') | finish | endif
let g:loaded_undo = 1


" check for the 'persistent_undo' feature
if has('persistent_undo')
    " define undo dir
    let undo_dir = expand('~/.config/vim-persisted-undo/')

    " create undo dir iff it does not exist
    if !isdirectory(undo_dir)
        call system('mkdir -p ' . undo_dir)
    endif

    " let Vim know about the directory
    let &undodir = undo_dir

    "enable undo persistence.
    set undofile
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-motion-tutor.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-autosave.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-cursor.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-cmake.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-clipboard.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" if exists('g:loaded_clipboard') | finish | endif
" let g:loaded_clipboard = 1
"
" function! CutFunction()
"     execute "normal! \"rdiw"
" endfunction
" command! -nargs=* Cut :call CutFunction(<f-args>)
"
" function! CUTFunction()
"     execute "normal! \"rdiW"
" endfunction
" command! -nargs=* CUT :call CUTFunction(<f-args>)
"
" function! CopyFunction()
"     execute "normal! \"ryiw"
" endfunction
" command! -nargs=* Copy :call CopyFunction(<f-args>)
"
" function! COPYFunction()
"     execute "normal! \"ryiW"
" endfunction
" command! -nargs=* COPY :call COPYFunction(<f-args>)
"
" function! PasteFunction()
"     execute "normal! \".viw"
"     execute 'normal! P'
" endfunction
" command! -nargs=* Paste :call PasteFunction(<f-args>)
"
" function! PASTEFunction()
"     execute "normal! \".viW"
"     execute 'normal! P'
" endfunction
" command! -nargs=* PASTE :call PASTEFunction(<f-args>)
"
"
" nnoremap <Leader>x  :Cut<CR>
" nnoremap <Leader>X  :CUT<CR>
" nnoremap <Leader>y  :Copy<CR>
" nnoremap <Leader>Y  :COPY<CR>
" nnoremap <Leader>p  :Paste<CR>
" nnoremap <Leader>P  :PASTE<CR>
"
" clipboard: copy
vmap <C-C> "+yy

" clipboard: paste after word [p]
vnoremap <C-P> "+p
inoremap <C-P> "+p
nnoremap <C-P> "+p

" clipboard: paste before word [P]
" vnoremap <C-V> "+P
" nnoremap <C-V> "+P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-refactor.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto refreshing nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! AutoRefresh()
"     execute 'echo "refresh"'
" endfunction
"
" augroup NERDTree_autorefresh_au
"     autocmd!
"     autocmd WinEnter * :call AutoRefresh()
" augroup END

]]
