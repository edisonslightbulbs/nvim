-- table for string functions and variables
_G.config.str = {}

-- checks for an empty
config.str.empty = function(str)
    return str == nil or str == ''
end

-- strips white spaces from a string
config.str.strip = function(str)
    local stripped = string.gsub(str, '%s+', '')
    return stripped
end

-- returns delimeter separated tokens
config.str.split = function(str, delimeter)
    if config.str.empty(delimeter) then
        delimeter = "%s"
    end
    local tokens = {}
    for token in string.gmatch(str, "([^" .. delimeter .. "]+)") do
        table.insert(tokens, token)
    end
    return tokens
end

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

require('utilities.tab')
require('utilities.git')
require('utilities.path')
require('utilities.buffer')
require('utilities.window')
