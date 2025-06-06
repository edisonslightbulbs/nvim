-- returns delimeter separated tokens
config.os = function()
    local uname_info = vim.loop.os_uname()
    local sysname = uname_info.sysname

    if sysname == "Linux" then
        return "Linux"
    elseif sysname == "Darwin" then
        return "macOS"
    elseif sysname == "Windows_NT" then
        return "Windows"
    else
        return "Unknown"
    end
end
