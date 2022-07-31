-- returns buffer count including no name buffer
_G.bufcount = function()
	-- in vanilla vim: return len(getbufinfo({'buflisted':1}))
	return vim.fn.len(vim.fn.getbufinfo({ buflisted = true }))
end

-- last buffer?
_G.is_lastbuf = function()
	if bufcount() <= 1 then
		return true
	end
	return false
end

-- last win?
_G.is_lastwin = function()
	local winid = vim.fn.winnr()
	if winid == 1 and winid == vim.fn.winnr('$') then
		return true
	end
	return false
end

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

-- buffer writable?
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

-- buffer savable?
_G.is_savable = function()
	if is_writable() and not is_nvtree() and not is_noname() then
		return true
	end
	return false
end

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
