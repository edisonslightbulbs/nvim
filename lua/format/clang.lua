-- table for clang functions and variables
_G.config.clang = {}

config.clang.path = config.path.join(vim.fn.stdpath("config"), "format", ".clang-format")
config.clang.formatter = "C:\\Users\\zoemthun\\AppData\\Local\\anaconda3\\envs\\nvim\\Scripts\\clang-format.exe"

if config.path.exists(config.clang.path) == false then
    error("Unable to resolve " .. config.clang.path)
end

if config.path.exists(config.clang.formatter) == false then
    error("Unable to resolve " .. config.clang.formatter)
end

config.clang.source = function()
    local filepath = vim.fn.expand("%:p")                  -- gets the full path of the current file
    local target_dir = vim.fn.fnamemodify(filepath, ":h")  -- extracts the directory from the file path
    local path = target_dir .. "/.clang-format"            -- Constructs the .clang-format path in target directory
    return path
end

vim.cmd("autocmd BufEnter *.cpp,*.hpp,*.h lua config.file.copy(config.clang.path, config.clang.source())")
