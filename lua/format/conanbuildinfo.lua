-- table for clang functions and variables
_G.config.conanbuildinfo = {}

-- cache conanbuildinfo path for each project
config.conanbuildinfo.cache = {}

-- function to find the directory containing conanbuildinfo.json or compile_commands.json
config.cmake.find_conanbuildinfo = function()
    -- check if the current buffer's filetype is cpp, h, or hpp
    local filetype = vim.bo.filetype
    if filetype ~= 'cpp' and filetype ~= 'h' and filetype ~= 'hpp' then
        return ""
    end

    local root = config.git.root()

    -- Check cached paths
    if config.conanbuildinfo.cache[root] then
        print("-- using cached path: " .. config.conanbuildinfo.cache[root])
        return config.conanbuildinfo.cache[root]
    end

    local path = vim.fn.expand('%:p:h')
    local depth = 10
    local counter = 0

    local function search(dir)
        if counter >= depth or (dir == root and counter > 0) then
            return ""
        end

        local build = dir .. '/build/Release'
        local conanbuildinfo_path = build .. '/conanbuildinfo.json'
        local compile_commands_path = build .. '/compile_commands.json'

        if vim.fn.isdirectory(build) ~= 0 then
            if vim.fn.filereadable(conanbuildinfo_path) ~= 0 then
                config.conanbuildinfo.cache[root] = build  -- cache the result
                return build
            elseif vim.fn.filereadable(compile_commands_path) ~= 0 then
                config.conanbuildinfo.cache[root] = build  -- cache the result
                return build
            end
        end

        counter = counter + 1
        local parent_dir = vim.fn.fnamemodify(dir, ':h')
        return search(parent_dir)
    end

    local result = search(path)
    if result == "" then
        print("-- compile commands not found")
    else
        print("-- compile commands found")
    end

    return result
end
