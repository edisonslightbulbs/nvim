-- returns buffer count including no name buffer
_G.bufcount = function()
	return vim.fn.len(vim.fn.getbufinfo({ buflisted = true }))
end

-- returns true or false on last buffer check
_G.is_lastbuf = function()
	if bufcount() <= 1 then
		return true
	end
	return false
end

-- returns true or false on last window check
_G.is_lastwin = function()
	local winid = vim.fn.winnr()
	if winid == 1 and winid == vim.fn.winnr('$') then
		return true
	end
	return false
end

-- returns true or false on noname buffer check
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

-- returns true or false on buffer writable check
_G.is_writable = function()
	if vim.bo.modifiable and is_empty(vim.bo.buftype) and not is_empty(vim.bo.filetype) then
		return true
	end
	return false
end

-- returns true or false on NvimTree buffer check
_G.is_nvtree = function()
	if vim.bo.filetype == 'NvimTree' then
		return true
	end
	return false
end

-- returns true or false on buffer savable check
_G.is_savable = function()
	if is_writable() and not is_nvtree() and not is_noname() then
		return true
	end
	return false
end

-- returns true or false on work buffer check
_G.is_workbuf = function(bufid)
	if
		vim.fn.buflisted(bufid)
		and vim.fn.bufloaded(bufid) == 1
		and not is_empty(vim.fn.bufname(bufid))
		and vim.fn.bufname(bufid) ~= 'NvimTree_1'
	then
		return true
	end
	return false
end
