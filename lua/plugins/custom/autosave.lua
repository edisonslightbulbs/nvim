-- autosave feature
local load_autosave = 1

-- activates autosave plugin
function AutoSave()
    if IsSavable() and load_autosave == 1 then
        local view = vim.fn.winsaveview()
        vim.api.nvim_command("%s/\\s\\+$//e")
        vim.fn.winrestview(view)
        vim.api.nvim_command("write")
    end
end

local autosave = vim.api.nvim_create_augroup("AutoSave", {clear = true})
vim.api.nvim_create_autocmd(
    {"TextChanged", "InsertLeave", "BufLeave", "VimLeavePre", "WinLeave", "TextChangedI"},
    {
        pattern = "*",
        group = autosave,
        desc = "autosaves work",
        callback = function()
            AutoSave()
        end
    }
)

-- deactivates autosave plugin
function NoAutoSave()
    load_autosave = 0
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.swapfile = false
    vim.api.nvim_command("noundofile")
end

-- augroup noautosave_au
-- autocmd!
-- autocmd BufReadPost * : call NoAutoSave()
-- augroup END

local undodir = JoinPath(vim.fn.stdpath("config"), "autosave", "undo")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.system {"mkdir", "-p", undodir}
end

vim.opt.undodir = undodir
vim.opt.undofile = true
