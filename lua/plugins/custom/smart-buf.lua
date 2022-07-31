--[[ vim.fn.winbufnr(winid)
     given a window id (winid), returns the number buffers that window]]

--[[ vim.fn.bufwinnr(bufid)
     given a buffer id (bufid), returns the window id of that buffer]]

--
-- local function other_buftabs(bufid, winid, cur_buf, cur_win)
--     if vim.fn.buflisted(bufid) and vim.fn.bufloaded(bufid) == 1 and not is_empty(vim.fn.bufname(bufid)) and
--         vim.fn.bufname(bufid) ~= 'NvimTree_1' and bufid ~= cur_buf and winid == cur_win then
--         return true
--     end
--     return false
-- end
--
-- _G.close_other_buftabs = function()
--     local cur_buf = vim.fn.bufnr('%')
--     local lst_buf = vim.fn.bufnr('$')
--
--     local cur_win = vim.fn.winnr()
--     local lst_win = vim.fn.winnr('$')
--
--     local BUFCOUNT = 1
--     local FIRST_BUF = 1
--     local FIRST_WIN = 1
--
--     -- iterate over all the windows
--     for winid = FIRST_WIN, lst_win, 1 do
--         print("working on window: " .. winid)
--
--         --[[ iff a window has one buffer, check if  its an 'NvimTree_1'
--               buffer iff it is, ignore that specific window ]]
--         local win_bufcount = vim.fn.winbufnr(winid)
--         local buf_winid = vim.fn.bufwinnr('NvimTree_1')
--         if win_bufcount == BUFCOUNT and buf_winid == winid then goto continue end
--
--         --[[ for each window, iterate over all buffers ... ]]
--         for bufid = FIRST_BUF, lst_buf, 1 do
--
--             --[[ ... iff a buffer is associated with the current window,
--                  write changes made to it and unload it ]]
--             if other_buftabs(bufid, winid, cur_buf, cur_win) then
--                 --savebuf()
--                 print('deleting' .. bufid)
--                 vim.api.nvim_command('bd ' .. bufid)
--             end
--         end
--     end
--     ::continue::
-- end
--
--local function is_nvimtree_open()
--	if vim.fn.bufwinnr('NvimTree_1') == 1 then
--		return true
--	end
--	return false
--end
--
--local function smart_buf()
--	local last_window = vim.fn.winnr('$')
--
--	print('number of windows: ' .. last_window)
--
--	-- for winid = 1, last_window, 1 do
--	-- end
--end
--
--local smartbuf = vim.api.nvim_create_augroup('SmartBuf', { clear = true })
--vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--	pattern = '*',
--	group = smartbuf,
--	desc = 'applies a custom window-buffer workflow',
--	callback = function()
--		smart_buf()
--	end,
--})
--				local bufname = vim.api.nvim_buf_get_name(bufid)

-- cycle to next buffer
_G.next_buf = function()
	if not is_nvtree() then
		local next = tonumber(vim.fn.bufnr('%')) + 1
		for bufid = next, vim.fn.bufnr('$'), 1 do
			if is_workbuf(bufid) and vim.fn.bufwinnr(bufid) == -1 then
				vim.api.nvim_command('bn')
				return
			end
		end
	end
end

-- cycle to previous buffer
_G.prev_buf = function()
	if not is_nvtree() then
		local prev = tonumber(vim.fn.bufnr('%')) - 1
		for bufid = prev, 1, -1 do
			if is_workbuf(bufid) and vim.fn.bufwinnr(bufid) == -1 then
				vim.api.nvim_command('bN')
				return
			end
		end
	end
end

--_G.unload_buf = function()
--    if bufenum() > 1 then
--        vim.api.nvim_command('bp |bd #')
--    else
--        vim.api.nvim_command('bd!')
--    end
--end

_G.unload_other_bufs = function()
	for bufid = 1, vim.fn.bufnr('$'), 1 do
		if is_workbuf(bufid) and vim.fn.bufwinnr(bufid) == -1 then
			vim.api.nvim_command('bd ' .. bufid)
		end
	end
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

map('n', '<S-Tab>', ':lua prev_buf()<CR>', opts) -- to previous buffer
map('n', '<leader><Tab>', ':lua next_buf()<CR>', opts) -- to next buffer
map('n', '<leader>o', ':lua unload_other_bufs()<CR>', opts) -- unload other buffers

map('n', '<leader>|', ':vnew %<CR>', opts) -- create new v-window
map('n', '<leader>d', ':lua close_buftab()<CR>', opts) -- unload current buffer
