vim.cmd [[
if exists('g:load_autosave') | finish | endif
let g:load_autosave = 1


function! Writable()
    """ checks if current buffer is writable
    """
    if &modifiable==#'1' && &buftype==#'' && &filetype !=#''
        return v:true
    elseif &modifiable!=#'1' || &buftype!=#'' || &filetype ==#''
        return v:false
    endif
endfunction


function! IsNvimTree_1()
    """ checks if current buffer is a NvimTree_1 buffer
    """
    if  &filetype ==#'NvimTree_1'
        return v:true
    else
        return v:false
    endif
endfunction


function! IsNoName()
    """ checks if current buffer is a No Name buffer
    """
    if &buftype==#'' && bufname('%')==#'' && &modifiable==#'1'
        return v:true
    else
        return v:false
    endif
endfunction


function! Savable()
    """ checks if current buffer is a working buffer.
    """
    if Writable() && !IsNvimTree_1()
        if !IsNoName()
            return v:true
        endif
    else
        return v:false
    endif
endfunction

function! AutoSave()
    """ autoSave
    """
    if Savable() && g:load_autosave ==1
        silent! execute 'edit!'
        silent! execute 'write'
    endif
endfunction

augroup autosave_au
    autocmd!
    " autosave cases:
    "   a. after text is changed in normal mode [ TextChanged ]
    "   b. when leaving insert mode [ InsertLeave ]
    "   c. before leaving a buffer [ BufLeave ]
    "   d. before exiting vim [ VimLeavePre ]
    "   d. before exiting vim [ VimLeavePre ]
    autocmd TextChanged,InsertLeave,BufLeave,VimLeavePre,FileChangedShell * :call AutoSave()
augroup END


function! DisableAutoSave()
    """ disables autosave
    """
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
