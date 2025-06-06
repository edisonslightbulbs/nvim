-- table for window functions and variables
_G.config.window = {}

-- returns true or false on last window check
config.window.last = function()
    return vim.fn.winnr('$') == 1
end
