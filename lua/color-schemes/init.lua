local settings = {
	termguicolors = true,  -- use gui colors
	colorcolumn = '65,80', -- show column highlight @ lines [65, 80]
	background = 'dark',   -- background color
}
for k, v in pairs(settings) do
	vim.opt[k] = v
end

local augroup = vim.api.nvim_create_augroup('BaseColorScheme', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'background-foreground highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'Normal', {
			fg = '#abb2b9',
			bg = '#1d2021',
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'cursor-line highlihgt',
	callback = function()
		vim.api.nvim_set_hl(0, 'CursorLine', {
			fg = '',
			bg = 'Black',
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'cursor line number',
	callback = function()
		vim.api.nvim_set_hl(0, 'CursorLineNr', {
			fg = 'White',
			bg = '#1d2021',
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'number-line highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'LineNr', {
			fg = '#808b96',
			bg = '#1d2021',
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'menu highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'Menu', {
			fg = '#eaecee',
			bg = '#1c2833',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'Pmenu', {
			fg = '#eaecee',
			bg = '#1c2833',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'PmenuSel', {
			fg = '#1c2833',
			bg = '#eaecee',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'PmenuSbar', {
			fg = '#eaecee',
			bg = '#1c2833',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'PmenuThumb', {
			fg = '#eaecee',
			bg = '#1c2833',
			bold = true,
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'sign-column highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'SignColumn', {
			fg = '',
			bg = '#21262c',
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'column highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'ColorColumn', {
			fg = '',
			bg = '#21262c',
		})
	end,
})

-- @todo find better color for spellings
vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'spellings highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'SpellBad', {
			fg = '#8f3f71',
			bg = '#1d2021',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'SpellCap', {
			fg = '#8f3f71',
			bg = '#1d2021',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'SpellLocal', {
			fg = '#8f3f71',
			bg = '#1d2021',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'SpellRare', {
			fg = '#8f3f71',
			bg = '#1d2021',
			bold = true,
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'search highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'Search', {
			fg = 'black',
			bg = '#F6D55C',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'IncSearch', {
			fg = 'black',
			bg = '#F6D55C',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'Visual', {
			fg = '#1c2833',
			bg = '#f8f5d7',
			bold = true,
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'split-boarder highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'VertSplit', {
			fg = '#5a5c5d',
			bg = '#21262c',
			bold = true,
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'matching-enclosure highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'MatchParen', {
			fg = 'white',
			bg = 'black',
			bold = true,
		})
	end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'status-line highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'StatusLine', {
			fg = 'Grey',
			bg = 'Black',
			bold = true,
		})
	end,
})

-- @todo: incremental improvements from this
--       point downwards
-- date: 2020-08-14 09:25
vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '',
	group = augroup,
	desc = 'tab-line highlight',
	callback = function()
		vim.api.nvim_set_hl(0, 'TabLine', {
			fg = 'Grey',
			bg = 'White',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'TabLineFill', {
			fg = 'Grey',
			bg = 'White',
			bold = true,
		})
		vim.api.nvim_set_hl(0, 'TabLineSel', {
			fg = 'Grey',
			bg = 'White',
			bold = true,
		})
	end,
})

require('color-schemes.gruvbox')

-- hint: highlight options
--   fg = "",
--   bg = "black",
--   ctermbg = "",
--   ctermfg = "",
--   bold = false,
--   standout = false,
--   underline = false,
--   underlineline = false,
--   undercurl = false,
--   underdot = false,
--   underdash = false,
--   strikethrough = false,
--   italic = false,
--   reverse = false,
--   nocombine = false
