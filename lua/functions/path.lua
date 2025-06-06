-- table for path functions and variables
_G.config.path = {}

-- cross platform seperator
config.path.sep = package.config:sub(1, 1)

-- join path
config.path.join = function(...)
    return table.concat({ ... }, config.path.sep)
end

-- check if path exists
config.path.exists = function(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
        if code == 13 then -- edge case: permission denied, but it exists
            return true
        end
    end
    return ok, err
end

-- get current work directory
config.path.cwd = function()
    local path = vim.api.nvim_buf_get_name(0)
    if config.str.empty(path:match('(.*' .. config.path.sep .. ')')) then
        return vim.fn.getcwd()
    end
    return path:match('(.*' .. config.path.sep .. ')')
end

-- get parent directory
config.path.parentdir = function()
    return config.path.join(config.path.cwd() .. '..')
end
