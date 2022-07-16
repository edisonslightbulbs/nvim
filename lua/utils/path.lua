-- seperator
_G.sep = package.config:sub(1, 1)

-- join path
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

-- find top-level .git directory
local iter = 0
local super = ''
local max_iter = 4
_G.find_gitdir = function(path)
	local next = ''
	if is_empty(path) then
		find_gitdir(parentdir())
	else
		next = join_path(path .. sep .. '..')
		local gitdir = next .. sep .. '.git'

		if iter < max_iter then
			iter = iter + 1
			if vim.fn.isdirectory(gitdir) == 1 then
				super = next
			end
			find_gitdir(next)
		end
	end
	iter = 0
	if is_empty(super) then
		return bufdir()
	end
	return super
end
