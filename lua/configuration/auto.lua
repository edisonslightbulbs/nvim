-- EXAMPLE:
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "lua", "text"},
--     callback = function()
--
--         -- an arbitrary data table
--         local data = {
--             buf = vim.fn.expand("<abuf>"),
--             file = vim.fn.expand("<afile>"),
--             match = vim.fn.expand("<amatch>"),
--         }
--
--         vim.schedule(function()
--             print("Hey, we go called")
--             print(vim.inspect(data))
--         end)
--     end,
-- })

local startup = vim.api.nvim_create_augroup("StartupMessage", {clear = true})
vim.api.nvim_create_autocmd(
    "VimEnter",
    {
        pattern = "",
        group = startup,
        desc = "all systems go",
        callback = function()
            if IsNoname then
                vim.opt.readonly = true
            end
            print("Now then, lets get started, shall we?")
        end
    }
)

vim.cmd [[
" use dir of working buffer
" augroup to_buff_dir
" autocmd!
" autocmd BufEnter * silent! lcd %:p:h
" augroup END

" silence pesky read only for git diff
" augroup noro_in_diff
" autocmd!
" autocmd BufEnter * if &diff | set noro |endif
" augroup END

" allow external file updates
" augroup check_ext_buff_changes
" autocmd!
" autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
" augroup END
]]
