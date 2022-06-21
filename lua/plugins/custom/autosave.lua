vim.cmd [[
"
" vim-autosave.vim
"   n.b.: uses command height of 2 (for convenience) vs silence
"
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
" @todo:
"    adapt to nvimtree!!
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
]]
