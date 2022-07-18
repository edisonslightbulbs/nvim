local status, nvim_tree = pcall(require, 'nvim-tree')
if not status then
	print('-- something went wrong while setting up nvim-tree!')
	return
end

nvim_tree.setup({
	create_in_closed_folder = true,
	hijack_unnamed_buffer_when_opening = true,
	view = {
		number = true,
		relativenumber = true,
		adaptive_size = false,
		mappings = {
			list = {
				{ key = 'u', action = 'dir_up' },
			},
		},
	},
	renderer = {
		group_empty = true,
		icons = {
			glyphs = {
				default = '',
				symlink = '',
				folder = {
					arrow_closed = '',
					arrow_open = '',
					default = '',
					open = '',
					empty = '',
					empty_open = '',
					symlink = '',
					symlink_open = '',
				},
				git = {
					unstaged = '',
					staged = '',
					unmerged = '',
					renamed = '',
					untracked = '',
					deleted = '',
					ignored = '',
				},
			},
		},
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
	filters = {
		dotfiles = false,
		exclude = { '*.metainfo', '*.py.lock' },
		custom = { 'autoload', 'spell' },
	},
	git = {
		enable = false,
		ignore = false,
		timeout = 1,
	},
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<leader><Space>', ':NvimTreeToggle<CR>', opts)
