_G.close_tab = function()
    if bufenum() > 1 then
        vim.api.nvim_command('bp |bd #')
    else
        vim.api.nvim_command('bd!')
    end
end

local function other_tabs(bufid, winid, cur_buf, cur_win)
    if vim.fn.buflisted(bufid) and vim.fn.bufloaded(bufid) == 1 and not is_empty(vim.fn.bufname(bufid)) and
        vim.fn.bufname(bufid) ~= 'NvimTree_1' and bufid ~= cur_buf and winid == cur_win then
        return true
    end
    return false
end

_G.close_other_tabs = function()
    local cur_buf = vim.fn.bufnr('%')
    local lst_buf = vim.fn.bufnr('$')

    local cur_win = vim.fn.winnr()
    local lst_win = vim.fn.winnr('$')

    local BUFCOUNT = 1
    local FIRST_BUF = 1
    local FIRST_WIN = 1

    -- iterate over all the windows
    for winid = FIRST_WIN, lst_win, 1 do

        --[[ iff a window has one buffer, check if  its an 'NvimTree_1'
              buffer iff it is, ignore that specific window ]]
        local win_bufcount = vim.fn.winbufnr(winid)
        local buf_winid = vim.fn.bufwinnr('NvimTree_1')
        if win_bufcount == BUFCOUNT and buf_winid == winid then goto continue end

        --[[ for each window, iterate over all buffers ... ]]
        for bufid = FIRST_BUF, lst_buf, 1 do

            --[[ ... iff a buffer is associated with the current window,
                 write changes made to it and unload it ]]
            if other_tabs(bufid, winid, cur_buf, cur_win) then
                bufsave()
                vim.api.nvim_command('bd ' .. bufid)
            end
        end
    end
    ::continue::
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<S-Tab>', ':bN<CR>', opts) -- cycle to previous buffer
map('n', '<leader><Tab>', ':bn<CR>', opts) -- cycle to next buffer
map('n', '<leader>|', ':vnew %<CR>', opts) -- create new v-window
map('n', '<leader>d', ':lua close_tab()<CR>', opts) -- unload current buffer
map('n', '<leader>o', ':lua close_other_tabs()<CR>', opts) -- unload other buffers

_G.test = function()
    close_tab()
end


-- ROADMAP:
-- 1. write an au function that is triggered before deleting a buffer
-- 2. make sure that windows *always* have unique buffers
--
-- ISSUES:
--


-- notes:
-- vim.fn.winbufnr(winid)
--   given a window id (winid), returns the number buffers that window

-- vim.fn.bufwinnr(bufid)
--   given a buffer id (bufid), returns the window id of that buffer
