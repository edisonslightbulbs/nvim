local status, ret = pcall(require, "telescope")
if not status then
    print("-- something went wrong while setting up telescope!")
    return
end

require('telescope').setup{
    no_ignore = true,
}

local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- search git project (honor .gitignore)
map('n', 'tr', ':Telescope git_files <CR>', opts)

-- search git project (disregard .gitignore)
map('n', 'tg', ':Telescope live_grep <CR>', opts)

-- search git project (disregard .gitignore)
map('n', 'tf', '<cmd>lua require("telescope.builtin").find_files({ no_ignore = true })<CR>', opts)

--[[ { no_ignore = true }
       show files ignored by .gitignore,.ignore, etc. (default: false)
--]]
