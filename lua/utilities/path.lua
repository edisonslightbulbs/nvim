-- seperator (cross platform)
_G.sep = package.config:sub(1, 1)

-- returns a joined path 
-- @todo: rename to path
_G.join_path = function(...)
	return table.concat({ ... }, sep)
end

-- path exists?
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

-- returns current directory
-- @todo: rename to dir
_G.bufdir = function()
	local bufpath = vim.api.nvim_buf_get_name(0)
	if is_empty(bufpath:match('(.*' .. sep .. ')')) then
		return vim.fn.getcwd()
	end
	return bufpath:match('(.*' .. sep .. ')')
end

-- return current parent directory
_G.parentdir = function()
	return join_path(bufdir() .. '..')
end

