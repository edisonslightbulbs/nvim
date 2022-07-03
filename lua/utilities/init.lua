-- joins paths (cross platform)
function JoinPath(...)
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
local function empty(str)
    return str == nil or str == ""
end

-- checks for a [No Name] buf
function IsNoname()
    if vim.bo.modifiable and empty(vim.bo.buftype) and empty(vim.fn.expand("%")) and empty(vim.bo.filetype) then
        return true
    else
        return false
    end
end

-- checks if current tab is the last tab
function IsLastTab()
    return true
end

-- checks if current win is the last window
function IsLastWin()
    if IsLastTab() then
        if vim.fn.winnr() == vim.fn.winnr("$") then
            return true
        else
            return false
        end
    else
        return false
    end
end

-- checks if current buf is the last buf [@todo: buggy implementation]
function IsLastBuf()
    if IsLastWin() then
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

function IsWritable()
    -- checks if current buffer is writable
    if vim.bo.modifiable and empty(vim.bo.buftype) and not empty(vim.bo.filetype) then
        return true
    else
        return false
    end
end

function IsNvimTree()
    -- checks if current buffer NvimTree
    if vim.bo.filetype == "NvimTree" then
        return true
    else
        return false
    end
end

function IsSavable()
    -- checks if current buffer is a working/savable buffer
    if IsWritable() and not IsNvimTree() and not IsNoname() then
        return true
    else
        return false
    end
end
