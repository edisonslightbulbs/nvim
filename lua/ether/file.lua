-- table for file functions and variables
_G.config.file = {}

-- check if the file exists
config.file.exists = function(path)
    local stat = vim.loop.fs_stat(path)
    return stat ~= nil
end

-- read from the source file
config.file.read = function(src_path, callback)
    vim.loop.fs_open(src_path, "r", 438, function(err, fd)
        if err then
            vim.api.nvim_err_writeln("Failed to open source file: " .. err)
            return
        end
        vim.loop.fs_fstat(fd, function(err, stat)
            if err then
                vim.api.nvim_err_writeln("Failed to stat source file: " .. err)
                vim.loop.fs_close(fd, function() end)
                return
            end
            vim.loop.fs_read(fd, stat.size, 0, function(err, data)
                vim.loop.fs_close(fd, function() end)
                if err then
                    vim.api.nvim_err_writeln("Failed to read source file: " .. err)
                    return
                end
                callback(data)
            end)
        end)
    end)
end

-- write to the destination file
config.file.write = function(dst_path, data)
    vim.loop.fs_open(dst_path, "w", 438, function(err, fd)
        if err then
            vim.api.nvim_err_writeln("Failed to open destination file: " .. err)
            return
        end
        vim.loop.fs_write(fd, data, 0, function(err)
            vim.loop.fs_close(fd, function() end)
            if err then
                vim.api.nvim_err_writeln("Failed to write to destination file: " .. err)
                return
            end
            config.file.permissions(dst_path)
        end)
    end)
end

-- set file permissions
config.file.permissions = function(path)
    local chmod = is_windows and "icacls " .. path .. " /grant Everyone:R" or "chmod 644 " .. path
    vim.loop.spawn(chmod, {args = {}, stdio = {nil, nil, nil}}, function(code)
        if code ~= 0 then
            vim.api.nvim_err_writeln("Failed to set permissions on " .. path)
        end
    end)
end

config.file.copy = function(src_path, dst_path)
    if not config.file.exists(dst_path) then
        config.file.read(src_path, function(data)
            config.file.write(dst_path, data)
        end)
    end
end
