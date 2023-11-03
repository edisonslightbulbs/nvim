-- table for git functions and variables
_G.config.git = {}

-- find top-level .git directory
config.git.root = function(callback)
    local path = vim.fn.expand('%:p:h')
    local counter = 0

    local function check_git_dir()
        if counter >= 8 then
            callback(vim.fn.expand('%:p:h'))
            return
        end

        local gitdir = path..'/.git'

        vim.fn.jobstart({"test", "-d", gitdir}, {
            on_exit = function(_, exit_code)
                if exit_code == 0 then
                    callback(path)
                else
                    path = vim.fn.fnamemodify(path, ':h')
                    counter = counter + 1
                    check_git_dir()
                end
            end
        })
    end

    check_git_dir()
end
