-- table for path functions and variables
_G.config.host = {}

-- find target executable
config.host.find = function(exec)
    local sep = package.config:sub(1, 1)
    local paths = config.str.split(vim.fn.getenv("PATH"), sep)

    for _, dir in ipairs(paths) do
        local execpath = vim.fn.glob(dir .. sep .. exec .. (vim.fn.has("win32") == 1 and ".exe" or ""))
        if execpath ~= "" then
            return execpath
        end
    end

    return nil
end

-- designate host executables
local win32 = vim.fn.has("win32") == 1

-- specific paths for Python and Ruby on Windows
local py3 = win32 and vim.fn.expand("%LOCALAPPDATA%") .. "\\anaconda3\\envs\\nvim\\python.exe" or "python3.8"
local py2 = win32 and vim.fn.expand("%LOCALAPPDATA%") .. "\\Microsoft\\WindowsApps\\python.exe" or "python"
local rb = win32 and "C:\\Ruby30-x64\\bin\\ruby.exe" or "ruby"

-- assigning host programs
vim.g.python3_host_prog = vim.fn.filereadable(py3) == 1 and py3 or config.host.find("python3.8")
vim.g.python_host_prog = vim.fn.filereadable(py2) == 1 and py2 or config.host.find("python")
vim.g.ruby_host_prog = win32 and (vim.fn.filereadable(rb) == 1 and rb or config.host.find("ruby")) or nil
