-- autosave feature
local load_autosave = 1

-- autosave current buffer
_G.savebuf = function()
	if is_savable() and load_autosave == 1 then
		local view = vim.fn.winsaveview()
		vim.api.nvim_command('%s/\\s\\+$//e')
		vim.fn.winrestview(view)
		vim.api.nvim_command('silent! write')
	end
end

local ausave = vim.api.nvim_create_augroup('AutoSave', { clear = true })
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'BufLeave', 'VimLeavePre', 'WinLeave' }, {
	pattern = '*',
	group = ausave,
	desc = 'auto saves current buffer',
	callback = function()
		savebuf()
	end,
})

-- disable autosave
_G.disable_savebuf = function()
	load_autosave = 0
	vim.opt.backup = false
	vim.opt.writebackup = false
	vim.opt.swapfile = false
	vim.api.nvim_command('noundofile')
end

local undodir = join_path(vim.fn.stdpath('config'), 'autosave', 'undo')
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.system({ 'mkdir', '-p', undodir })
end

vim.opt.undodir = undodir
vim.opt.undofile = true
