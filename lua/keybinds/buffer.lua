local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

map('n', '<leader>|', ':vnew %<CR>', opts)                        -- create new v-window
map('n', '<C-s>', ':lua config.buffer.strip() <CR>', opts)        -- remove trailing white spaces
map('n', '<S-Tab>', ':lua config.buffer.previous()<CR>', opts)    -- to previous buffer
map('n', '<leader>d', ':lua config.buffer.unload()<CR>', opts)    -- unload current buffer
map('n', '<leader><Tab>', ':lua config.buffer.next()<CR>', opts)  -- to next buffer
map('n', '<leader>o', ':lua config.buffer.unloadall()<CR>', opts) -- unload all other buffers
