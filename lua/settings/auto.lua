-- where elegance meets consistency
local group = vim.api.nvim_create_augroup("startup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", { command = "echo 'Now then, lets get started, shall we?'", group = "startup"})

-- concept
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "text"},
    callback = function()

        -- my data table
        local data = {
            buf = vim.fn.expand("<abuf>"),
            file = vim.fn.expand("<afile>"),
            match = vim.fn.expand("<amatch>"),
        }
        vim.schedule(function()
            print("Hey, we go called")
            print(vim.inspect(data))
        end)
    end,
})



vim.cmd [[
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

]]
