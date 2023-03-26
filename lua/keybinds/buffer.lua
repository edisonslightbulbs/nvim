-- jump to the next buffer in the list of previously edited buffers
_G.next_buf = function()
  local prev_buf = vim.fn.bufnr('#')  -- Get the previously edited buffer
  local num_bufs = vim.fn.bufnr('$')
  for buf_id = prev_buf + 1, num_bufs do
    if vim.fn.buflisted(buf_id) == 1 and is_workbuf(buf_id) and vim.fn.bufwinnr(buf_id) == -1 then
      vim.api.nvim_command('buffer ' .. buf_id)
      return
    end
  end
  for buf_id = 1, prev_buf - 1 do
    if vim.fn.buflisted(buf_id) == 1 and is_workbuf(buf_id) and vim.fn.bufwinnr(buf_id) == -1 then
      vim.api.nvim_command('buffer ' .. buf_id)
      return
    end
  end
end

-- jump to the previous buffer in the list of previously edited buffers
_G.prev_buf = function()
  local prev_buf = vim.fn.bufnr('#')  -- Get the previously edited buffer
  local num_bufs = vim.fn.bufnr('$')
  for buf_id = prev_buf - 1, 1, -1 do
    if vim.fn.buflisted(buf_id) == 1 and is_workbuf(buf_id) and vim.fn.bufwinnr(buf_id) == -1 then
      vim.api.nvim_command('buffer ' .. buf_id)
      return
    end
  end
  for buf_id = num_bufs, prev_buf + 1, -1 do
    if vim.fn.buflisted(buf_id) == 1 and is_workbuf(buf_id) and vim.fn.bufwinnr(buf_id) == -1 then
      vim.api.nvim_command('buffer ' .. buf_id)
      return
    end
  end
end

_G.unload_other_bufs = function()
  for bufid = 1, tonumber(vim.fn.bufnr('$')), 1 do
    if is_workbuf(bufid) and vim.fn.bufwinnr(bufid) == -1 then
      vim.api.nvim_command('bd ' .. bufid)
    end
  end
end

_G.unload_buf = function()
    if bufcount() > 1 then
        vim.api.nvim_command('bp |bd #')
    else
        vim.api.nvim_command('bd!')
    end
end

_G.strip_trailing_white_spaces = function()
    vim.api.nvim_command(':call feedkeys("\\<esc>")')
    vim.api.nvim_command('%s/\\s\\+$//e')
    vim.api.nvim_command('let @/=""')
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

map('n', '<leader>|', ':vnew %<CR>', opts)                           -- create new v-window
map('n', '<S-Tab>', ':lua prev_buf()<CR>', opts)                     -- to previous buffer
map('n', '<leader>d', ':lua unload_buf()<CR>', opts)                 -- unload current buffer
map('n', '<leader><Tab>', ':lua next_buf()<CR>', opts)               -- to next buffer
map('n', '<leader>o', ':lua unload_other_bufs()<CR>', opts)          -- unload other buffers
map('n', '<C-s>', ':lua strip_trailing_white_spaces() <CR>', opts)   -- remove trailing white spaces
