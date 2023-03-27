-- table for window functions and variables
_G.config.window = {}

-- returns true or false on last window check
config.window.last = function()
	local winid = vim.fn.winnr()
	if winid == 1 and winid == vim.fn.winnr('$') then
		return true
	end
	return false
end
