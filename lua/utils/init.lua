-- path sep (cross platform)
_G.sep = package.config:sub(1, 1)

-- joins path (cross platform)
_G.join_path = function(...)
    local joined = table.concat({ ... }, sep)
    return joined
end

-- checks for an empty str
_G.empty_str = function(str)
    return str == nil or str == ''
end

-- checks if file or dir exists
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

-- checks for [No Name] buf
_G.noname = function()
    if vim.bo.modifiable
        and empty_str(vim.bo.buftype)
        and empty_str(vim.fn.expand('%'))
        and empty_str(vim.bo.filetype)
    then
        return true
    else
        return false
    end
end

-- @todo: checks last tab[ @todo ]
_G.lastab = function()
    return true
end

-- @todo: checks last window[ @todo ]
_G.lastwin = function()
    if lastab() then
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
_G.lastbuf = function()
    if lastwin() then
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

-- checks if buffer is modifiable
_G.writable = function()
    if vim.bo.modifiable and empty_str(vim.bo.buftype) and not empty_str(vim.bo.filetype) then
        return true
    else
        return false
    end
end

-- checks if buffer is NvimTree
_G.nvtree = function()
    if vim.bo.filetype == 'NvimTree' then
        return true
    else
        return false
    end
end

-- checks if buffer is writable
_G.savable = function()
    if writable() and not nvtree() and not noname() then
        return true
    else
        return false
    end
end

-- strips spaces from a string
_G.strip_str = function(str)
    local stripped = string.gsub(str, '%s+', '')
    return stripped
end

-- iterate parent dirs
-- todo: getcwd() is no what we are looking for here
local iter = 0
local max_iter = 4
local super = ''
_G.git_root = function(path)
    local parentdir = ''
    if empty_str(path) then
        parentdir = join_path(vim.fn.getcwd() .. sep .. '..')
        git_root(parentdir)
    else
        parentdir = join_path(path .. sep .. '..')
        local level = parentdir .. sep .. '.git'

        if iter < max_iter then
            iter = iter + 1
            if exists(level) then
                super = parentdir
            end
            git_root(parentdir)
        end
    end
    iter = 0
    if empty_str(super) then
        return vim.fn.getcwd()
    end
    return super
end
