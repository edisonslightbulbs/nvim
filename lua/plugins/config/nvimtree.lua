-- aliases
local map =  vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


--setup
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})


-- key mapping/s
map('n', '<leader>t', ':NvimTreeToggle<CR>', opts) -- toggle
