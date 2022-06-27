vim.cmd [[
function! IsLastWindow()
""" Checks if current window is last window
"""
    if winnr() == winnr('$')
        return v:true
    else
        return v:false
    endif
endfunction

function! IsLastBuffer()
""" Verifies current buffer is last buffer
"""
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

function! Writable()
    """ checks if current buffer is writable
    """
    if &modifiable==#'1' && &buftype==#'' && &filetype !=#''
        return v:true
    elseif &modifiable!=#'1' || &buftype!=#'' || &filetype ==#''
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
]]

-- detect os
function opsys()
    if vim.fn.has("unix") == 1 then
        print("unix")
    elseif vim.fn.has("win32") == 1 then
        print("win32")
    end
end
