-- CURRENT BUFFER

-- path sep
_G.sep = package.config:sub(1, 1)

-- joins path
_G.join_path = function(...)
    local joined = table.concat({ ... }, sep)
    return joined
end

-- checks for an empty str
_G.is_empty = function(str)
    return str == nil or str == ''
end

-- returns *current* buffer directory
_G.bufdir = function()
    local bufpath = vim.api.nvim_buf_get_name(0)
    if is_empty(bufpath:match("(.*" .. sep .. ")")) then
        return vim.fn.getcwd()
    end
    return bufpath:match("(.*" .. sep .. ")")
end

-- returns parent directory of *current* buffer
_G.parentdir = function()
    return join_path(bufdir() .. '..')
end

-- checks if file/dir exists
_G.exists = function(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
        -- edge case: permission denied, but it exists
        if code == 13 then
            return true
        end
    end
    return ok, err
end

-- checks if buf [No Name]
_G.is_noname = function()
    if vim.bo.modifiable
        and is_empty(vim.bo.buftype)
        and is_empty(vim.fn.expand('%'))
        and is_empty(vim.bo.filetype)
    then
        return true
    else
        return false
    end
end

-- @todo: checks last tab[ @todo ]
_G.is_lastab = function()
    return true
end

-- @todo: checks last window[ @todo ]
_G.is_lastwin = function()
    if is_lastab() then
        if vim.fn.winnr() == vim.fn.winnr('$') then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- @todo: checks last buf [ @todo: buggy implementation ]
_G.is_lastbuf = function()
    if is_lastwin() then
        local bufcount = 0
        for buf = 0, vim.fn.bufnr('$'), 1 do
            if vim.fn.buflisted(buf) == 1
                and vim.fn.bufloaded(buf) == 1
                and vim.fn.empty(vim.fn.win_findbuf(buf)) == 1
            then
                bufcount = bufcount + 1
            end
        end

        if bufcount <= 1 then
            print('this is the last buffer')
            return true
        else
            print('bufcount: ' .. bufcount .. ' ...this is not the last buffer!!')
            return false
        end
    else
        return false
    end
end

-- checks if buffer modifiable
_G.is_writable = function()
    if vim.bo.modifiable and is_empty(vim.bo.buftype) and not is_empty(vim.bo.filetype) then
        return true
    else
        return false
    end
end

-- checks if NvimTree buffer
_G.is_nvtree = function()
    if vim.bo.filetype == 'NvimTree' then
        return true
    else
        return false
    end
end

-- checks if buffer is writable
_G.is_savable = function()
    if is_writable() and not is_nvtree() and not is_noname() then
        return true
    else
        return false
    end
end

-- strips spaces from a string
_G.strip = function(str)
    local stripped = string.gsub(str, '%s+', '')
    return stripped
end

local iter = 0
local super = ''
local max_iter = 4

-- find top level git root
_G.git_root = function(path)
    local next = ''
    if is_empty(path) then
        git_root(parentdir())
    else
        next = join_path(path .. sep .. '..')
        local gitdir = next .. sep .. '.git'

        if iter < max_iter then
            iter = iter + 1
            if exists(gitdir) then
                super = next
            end
            git_root(next)
        end
    end
    iter = 0
    if is_empty(super) then
        return bufdir()
    end
    return super
end
