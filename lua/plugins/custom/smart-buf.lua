-- notes:
-- vim.fn.winbufnr(winid)
--   given a window id (winid), returns the number buffers that window

-- vim.fn.bufwinnr(bufid)
--   given a buffer id (bufid), returns the window id of that buffer


local function work_buf(bufid, winid, cur_buf, cur_win)
    if vim.fn.buflisted(bufid) and vim.fn.bufloaded(bufid) == 1 and not is_empty(vim.fn.bufname(bufid)) and
        vim.fn.bufname(bufid) ~= 'NvimTree_1' and bufid ~= cur_buf and winid == cur_win then
        return true
    end
end

_G.close_others = function()
    local cur_buf = vim.fn.bufnr('%')
    local lst_buf = vim.fn.bufnr('$')

    local cur_win = vim.fn.winnr()
    local lst_win = vim.fn.winnr('$')

    local BUFCOUNT = 1
    local FIRST_BUF = 1
    local FIRST_WIN = 1

    -- iterate over all the windows
    for winid = FIRST_WIN, lst_win, 1 do

        --[[ iff a window has one buffer, check if that buffer is nvimtree
             iff it is, lets ignore that window ]]
        local win_bufcount = vim.fn.winbufnr(winid)
        local buf_winid = vim.fn.bufwinnr('NvimTree_1')
        if win_bufcount == BUFCOUNT and buf_winid == winid then goto continue end

        -- iterate over all buffers
        for bufid = FIRST_BUF, lst_buf, 1 do

            --[[ iff buffer lives in same window as current buffer
                 write changes made to it and close it ]]
            if work_buf(bufid, winid, cur_buf, cur_win) then
                bufsave()
                vim.api.nvim_command('bd ' .. bufid)
                --print('window: ' .. winid .. ' - deleting buffer: ' .. bufid .. ' buffer name: ' .. vim.fn.bufname(bufid))
            end
        end
    end
    ::continue::
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }
map('n', '<leader>o', ':lua close_others()<CR>', opts)


-- roadmap:
-- 0. better behaviour for vnew
-- 1. write an au function that is triggered before deleting a buffer
-- 2. make sure that windows *always* have unique buffers
-- 3. navigate away from a buffer seamlessly on buffer delete operations
--
-- issues:
-- not working with only 2 windows?


vim.cmd([[
function! BuffNav()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
        let buff = bufname('')
        execute ':bN'
        execute ':bd ' . buff
        echo  buff . ' closed'
    else
        execute ':bd!'
    endif
endfunction
]])

map('n', '<S-Tab>', ':bN<CR>', opts) -- previous buffer
map('n', '<leader>0', ':edit!', opts) -- reload buffer << @todo: make auto >>
map('n', '<leader><Tab>', ':bn<CR>', opts) -- next buffer
map('n', '<leader>d', ':call BuffNav()<CR>', opts) -- delete buffer
map('n', '<leader>|', ':vnew %<CR>', opts) -- create new v-window

-- test
_G.tt = function()
    close_others()
end
