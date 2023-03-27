-- table for buffer functions and variables
_G.config.buffer = {}

-- returns buffer count including no name buffer
config.buffer.count = function()
    return vim.fn.len(vim.fn.getbufinfo({ buflisted = true }))
end

-- returns true or false on last buffer check
config.buffer.last = function()
    if config.buffer.count() <= 1 then
        return true
    end
    return false
end

-- returns true or false on noname buffer check
config.buffer.noname = function()
    if
        vim.bo.modifiable
        and config.str.empty(vim.bo.buftype)
        and config.str.empty(vim.fn.expand('%'))
        and config.str.empty(vim.bo.filetype)
    then
        return true
    end
    return false
end

-- returns true or false on buffer writable check
config.buffer.writable = function()
    if vim.bo.modifiable and config.str.empty(vim.bo.buftype) and not config.str.empty(vim.bo.filetype) then
        return true
    end
    return false
end

-- returns true or false on NvimTree buffer check
config.buffer.nvtree = function()
    if vim.bo.filetype == 'NvimTree' then
        return true
    end
    return false
end

-- returns true or false on buffer savable check
config.buffer.savable = function()
    if config.buffer.writable() and not config.buffer.nvtree() and not config.buffer.noname() then
        return true
    end
    return false
end

-- returns true or false on work buffer check
config.buffer.work = function(bufid)
    if
        vim.fn.buflisted(bufid)
        and vim.fn.bufloaded(bufid) == 1
        and not config.str.empty(vim.fn.bufname(bufid))
        and vim.fn.bufname(bufid) ~= 'NvimTree_1'
    then
        return true
    end
    return false
end

-- navigate to next buffer
config.buffer.next = function()
	if not config.buffer.nvtree() then
		local next = tonumber(vim.fn.bufnr('%')) + 1
		for bufid = next, vim.fn.bufnr('$'), 1 do
			if config.buffer.work(bufid) and vim.fn.bufwinnr(bufid) == -1 then
				vim.api.nvim_command('bn')
				return
			end
		end
	end
end

-- navigate to previous buffer
config.buffer.previous = function()
	if not config.buffer.nvtree() then
		local prev = tonumber(vim.fn.bufnr('%')) - 1
		for bufid = prev, 1, -1 do
			if config.buffer.work(bufid) and vim.fn.bufwinnr(bufid) == -1 then
				vim.api.nvim_command('bN')
				return
			end
		end
	end
end

-- unload (close) all open buffers 
config.buffer.unloadall = function()
  for bufid = 1, tonumber(vim.fn.bufnr('$')), 1 do
    if config.buffer.work(bufid) and vim.fn.bufwinnr(bufid) == -1 then
      vim.api.nvim_command('bd ' .. bufid)
    end
  end
end

-- unload current buffer 
config.buffer.unload = function()
    if config.buffer.count() > 1 then
        vim.api.nvim_command('bp |bd #')
    else
        vim.api.nvim_command('bd!')
    end
end

-- strip trailing white spaces
config.buffer.strip = function()
    vim.api.nvim_command(':call feedkeys("\\<esc>")')
    vim.api.nvim_command('%s/\\s\\+$//e')
    vim.api.nvim_command('let @/=""')
end
