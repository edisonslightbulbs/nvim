-- returns an enumeration of *all*
_G.bufenum = function()
	-- in vanilla vim: return len(getbufinfo({'buflisted':1}))
	return vim.fn.len(vim.fn.getbufinfo({ buflisted = true }))
end

-- last buffer?
_G.is_lastbuf = function()
	-- includes noname buffer
	if bufenum() <= 1 then
		return true
	end
	return false
end

-- last win?
_G.is_lastwin = function()
	local winid = vim.fn.winnr()
	local wincount = vim.fn.winnr('$')
	if winid == 1 and winid == wincount then
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
