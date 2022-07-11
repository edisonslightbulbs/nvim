local startup = vim.api.nvim_create_augroup("StartupMessage", {clear = true})
vim.api.nvim_create_autocmd(
"VimEnter",
{
    pattern = "",
    group = startup,
    desc = "all systems go",
    callback = function()
        print("Now then, lets get started, shall we?")
    end
}
)

local autoread = vim.api.nvim_create_augroup("ReloadFiles", {clear = true})
vim.api.nvim_create_autocmd(
{"CursorHold", "CursorHoldI", "FocusGained", "BufEnter"},
{
    pattern = "*",
    group = autoread,
    desc = "reloads buf if file modified outside nvim",
    callback = function()
        vim.api.nvim_command("checktime")
    end
}
)

local noreadonly = vim.api.nvim_create_augroup("EditGitDiff", {clear = true})
vim.api.nvim_create_autocmd(
"BufEnter",
{
    pattern = "*",
    group = noreadonly,
    desc = "removes readonly from git diffs",
    callback = function()
        if vim.api.nvim_win_get_option(0, "diff") then
            vim.opt.readonly = false
        end
    end
}
)

local conceal = vim.api.nvim_create_augroup("DisableConceal", {clear = true})
vim.api.nvim_create_autocmd(
{"BufEnter"},
{
    pattern = {"*.md", "*.json"},
    group = conceal,
    desc = "disables conceal for *.md and *.json",
    callback = function()
        vim.opt.conceallevel = 0
    end
}
)
