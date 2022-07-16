-- buffer noname?
_G.is_noname = function()
	if
		vim.bo.modifiable
		and is_empty(vim.bo.buftype)
		and is_empty(vim.fn.expand('%'))
		and is_empty(vim.bo.filetype)
	then
		return true
	end
	return false
end

-- buffer modifiable?
_G.is_writable = function()
	if vim.bo.modifiable and is_empty(vim.bo.buftype) and not is_empty(vim.bo.filetype) then
		return true
	end
	return false
end

-- buffer NvimTree?
_G.is_nvtree = function()
	if vim.bo.filetype == 'NvimTree' then
		return true
	end
	return false
end

-- buffer writable?
_G.is_savable = function()
	if is_writable() and not is_nvtree() and not is_noname() then
		return true
	end
	return false
end

-- @todo: checks last window[ @todo ]
_G.is_lastwin = function()
	if vim.fn.winnr() == vim.fn.winnr('$') then
		return true
	end
	return false
end

-- @todo: checks last buf [ @todo: buggy implementation ]
_G.is_lastbuf = function()
	if is_lastwin() then
		local bufcount = 0
		for buf = 0, vim.fn.bufnr('$'), 1 do
			if
				vim.fn.buflisted(buf) == 1
				and vim.fn.bufloaded(buf) == 1
				and vim.fn.empty(vim.fn.win_findbuf(buf)) == 1
			then
				bufcount = bufcount + 1
			end
		end

		if bufcount <= 1 then
			print('this is the last buffer')
			return true
		end
		print('bufcount: ' .. bufcount .. ' ...this is not the last buffer!!')
	end
	return false
end

_G.tt = function()
	local wincount = vim.fn.winnr('$')
	print(wincount)
end
