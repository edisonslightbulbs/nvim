vim.cmd [[
""" if exists('g:load_autosave') | finish | endif
""" if exists('g:load_undo') | finish | endif

let g:load_undo = 1
let g:load_autosave = 1

function! IsNvimTree_1()
    """ checks if current buffer is a NvimTree_1 buffer
    """
    if  &filetype ==#'NvimTree_1'
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
        let l:view = winsaveview()
        silent! execute '%s/\s\+$//e'
        call winrestview(l:view)
        silent! execute 'write'
    endif
endfunction


function! DisableAutoSave()
    """ disables autosave plugin
    """
    if &readonly
        let g:load_autosave = 0
        set nobackup
        set noswapfile
        set noundofile
    endif
endfunction

" setup undodir and undofile
if has('persistent_undo')
    let undo_dir = expand('~/.config/vim-persisted-undo/')
    if !isdirectory(undo_dir)
        call system('mkdir -p ' . undo_dir)
    endif
    let &undodir = undo_dir
    set undofile
endif

augroup autosave_au
    autocmd!
    " autosave cases:
    "   a. after text is changed in normal mode [ TextChanged ]
    "   b. when leaving insert mode [ InsertLeave ]
    "   c. before leaving a buffer [ BufLeave ]
    "   d. before exiting vim [ VimLeavePre ]
    autocmd TextChanged,InsertLeave,BufLeave,VimLeavePre *  :call AutoSave()
augroup END

augroup mansave_au
    autocmd!
    autocmd BufReadPost * : call DisableAutoSave()
augroup END
]]
