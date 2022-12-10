-- autosave feature
local load_autosave = 1

-- autosave current buffer
_G.savebuf = function()
    if is_savable() and load_autosave == 1 then
        vim.api.nvim_command('silent! write!')
    end
end

local ausave = vim.api.nvim_create_augroup('AutoSave', { clear = true })
vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'BufLeave', 'VimLeavePre', 'WinLeave' }, {
    pattern = { '*', 'yml', 'yaml', 'metainfo' },
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
    vim.fn.mkdir('p', undodir)
end

vim.opt.undodir = undodir
vim.opt.undofile = true


-- strip trailing white spaces
-- @todo place in dedicated module
_G.stripbuf = function()
    local view = vim.fn.winsaveview()
    vim.api.nvim_command('%s/\\s\\+$//e')
    vim.fn.winrestview(view)
end


local austrip = vim.api.nvim_create_augroup('AutoStrip', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertChange', 'BufLeave', 'VimLeavePre', 'WinLeave' }, {
    pattern = { '*', 'yml', 'yaml', 'metainfo' },
    group = austrip,
    desc = 'auto strip trailing white spaces in current buffer',
    callback = function()
        stripbuf()
    end,
})
