-- table for git functions and variables
_G.config.git = {}

-- Find top-level .git directory synchronously
config.git.root = function()
    local path = vim.fn.expand('%:p:h')
    local counter = 0
    local max_depth = 8

    while counter < max_depth do
        local gitdir = path..'/.git'
        if vim.fn.isdirectory(gitdir) ~= 0 then
            return path
        else
            path = vim.fn.fnamemodify(path, ':h')
            counter = counter + 1
        end
    end

    -- return the parent directory of the current file if .git is not found
    return vim.fn.fnamemodify(path, ':h')
end
