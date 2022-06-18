-- aliases
local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


--setup


-- key mapping/s
map('n', '<leader><Space>', ':Telescope git_files <CR>', opts) -- pull up telescope
--map('n', '<leader>', ':Telescope find_files <CR>', opts) -- pull up telescope

-- M.my_fd = function(opts)
--   opts = opts or {}
--   opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
--   require'telescope.builtin'.find_files(opts)
-- end
