local status, telescope = pcall(require, 'telescope')
if not status then
    print('-- something went wrong while setting up telescope!')
    return
end

telescope.setup({})
local sep = package.config:sub(1, 1)

local opts = {
    cwd = git_root(),
    file_ignore_patterns = {
        '%.metainfo',

        '^.git' .. sep,
        '^spell' .. sep,
        '^build' .. sep,
        '^cache' .. sep,
        '^autosave' .. sep,
        '^deprecated' .. sep,

        '^.' .. sep .. '.git' .. sep,
        '^.' .. sep .. 'spell' .. sep,
        '^.' .. sep .. 'build' .. sep,
        '^.' .. sep .. 'cache' .. sep,
        '^.' .. sep .. 'autosave' .. sep,
        '^.' .. sep .. 'deprecated' .. sep,
    },
    hidden = true,
    no_ignore = true,
}

_G.telescope_live_grep = function()
    require('telescope.builtin').live_grep(opts)
end

_G.telescope_find_files = function()
    require('telescope.builtin').find_files(opts)
end

_G.telescope_find_snippets = function()
    local snippets = join_path(vim.fn.stdpath('config'), 'snipps')
    require('telescope.builtin').find_files({ search_dirs = { snippets } })
end

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map('n', 'tg', ':lua telescope_live_grep()<CR>', opt)
map('n', 'tf', ':lua telescope_find_files()<CR>', opt)
map('n', 'ts', ':lua telescope_find_snippets()<CR>', opt)
