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

