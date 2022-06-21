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

]]