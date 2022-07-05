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

local workdir = vim.api.nvim_create_augroup("SetWorkDir", {clear = true})
vim.api.nvim_create_autocmd(
    {"BufEnter", "TextChanged"},
    {
        pattern = "*",
        group = workdir,
        desc = "set working directory to current buffer",
        callback = function()
            vim.api.nvim_command("lcd %:p:h")
        end
    }
)

-- EXAMPLE:
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "lua", "text"},
--     callback = function()
--
--         -- an arbitrary data table
--         local data = {
--             buf = vim.fn.expand("<abuf>"),
--             file = vim.fn.expand("<afile>"),
--             match = vim.fn.expand("<amatch>"),
--         }
--
--         vim.schedule(function()
--             print("Hey, we go called")
--             print(vim.inspect(data))
--         end)
--     end,
-- })
