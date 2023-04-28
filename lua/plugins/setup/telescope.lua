local status, telescope = pcall(require, 'telescope')
if not status then
	print('-- something went wrong while setting up telescope!')
	return
end

telescope.setup({})

local opts = {
	cwd = config.git.root(),
	file_ignore_patterns = {
		'%.metainfo',

		'^.git' .. config.path.sep,
		'^spell' .. config.path.sep,
		'^build' .. config.path.sep,
		'^cache' .. config.path.sep,
		'^deprecated' .. config.path.sep,
		'^autosave' .. config.path.sep .. 'undo' .. config.path.sep,
		'^.' .. config.path.sep .. '.git' .. config.path.sep,
		'^.' .. config.path.sep .. 'spell' .. config.path.sep,
		'^.' .. config.path.sep .. 'build' .. config.path.sep,
		'^.' .. config.path.sep .. 'cache' .. config.path.sep,
		'^.' .. config.path.sep .. 'deprecated' .. config.path.sep,
		'^.' .. config.path.sep .. 'autosave' .. config.path.sep .. 'undo' .. config.path.sep,
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
	local snippets = config.path.join(vim.fn.stdpath('config'), 'snipps')
	require('telescope.builtin').find_files({ search_dirs = { snippets } })
end

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

map('n', 'tg', ':lua telescope_live_grep()<CR>', opt)
map('n', 'tf', ':lua telescope_find_files()<CR>', opt)
map('n', 'ts', ':lua telescope_find_snippets()<CR>', opt)
