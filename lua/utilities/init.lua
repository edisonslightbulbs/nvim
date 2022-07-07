-- joins paths (cross platform)
_G.join_path = function(...)
    local sep = ""
    if vim.fn.has("unix") == 1 then
        sep = "/"
    elseif vim.fn.has("win32") == 1 then
        sep = "\\"
    end
    local joined = table.concat({...}, sep)
    return joined
end

-- checks for an empty str
_G.empty = function(str)
    return str == nil or str == ""
end

-- checks for a [No Name] buf
_G.noname = function()
    if vim.bo.modifiable and empty(vim.bo.buftype) and empty(vim.fn.expand("%")) and empty(vim.bo.filetype) then
        return true
    else
        return false
    end
end

-- @todo: checks if current tab is the last tab
_G.lastab = function()
    return true
end

-- @todo: checks if current win is the last window
_G.lastwin = function()
    if lastab() then
        if vim.fn.winnr() == vim.fn.winnr("$") then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- @todo: checks if current buf is the last buf [@todo: buggy implementation]
_G.lastbuf = function()
    if lastwin() then
        local bufcount = 0
        for buf = 0, vim.fn.bufnr("$"), 1 do
            if vim.fn.buflisted(buf) == 1 and vim.fn.bufloaded(buf) == 1 and vim.fn.empty(vim.fn.win_findbuf(buf)) == 1 then
                bufcount = bufcount + 1
            end
        end

        if bufcount <= 1 then
            print("this is the last buffer")
            return true
        else
            print("bufcount: " .. bufcount .. " ...this is not the last buffer!!")
            return false
        end
    else
        return false
    end
end

-- checks if current buffer is writable
_G.writable = function()
    if vim.bo.modifiable and empty(vim.bo.buftype) and not empty(vim.bo.filetype) then
        return true
    else
        return false
    end
end

-- checks if current buffer NvimTree
_G.nvtree = function()
    if vim.bo.filetype == "NvimTree" then
        return true
    else
        return false
    end
end

-- checks if current buffer is writable
_G.savable = function()
    if writable() and not nvtree() and not noname() then
        return true
    else
        return false
    end
end

-- recursively finds a git root directory regardless of submodules nested git repos
_G.git_root = function()
    local handle = assert(io.popen("git rev-parse --show-superproject-working-tree --show-toplevel | head -1", "r"))
    local str = handle:read("*all")
    handle:close()
    local path = string.gsub(str, "%s+", "")

    local parentdir = join_path(path, "..")

    handle =
        assert(
        io.popen("git -C " .. parentdir .. " rev-parse --show-superproject-working-tree --show-toplevel | head -1", "r")
    )
    str = handle:read("*all")
    handle:close()
    local super = string.gsub(str, "%s+", "")

    if not empty(super) then
        return super
    end
    return path
end
