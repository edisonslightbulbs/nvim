-- Table for path functions and variables
_G.config = _G.config or {}
_G.config.host = {}


-- Determine the operating system using vim.loop.os_uname()
local os_name = vim.loop.os_uname().sysname

if os_name == "Windows_NT" then
  vim.g.python3_host_prog = "C:\\Users\\ZOEMTHUN\\AppData\\Local\\anaconda3\\envs\\py38\\python.exe"
  vim.g.python_host_prog  = "C:\\Users\\ZOEMTHUN\\AppData\\Local\\anaconda3\\envs\\py2\\python.exe"
  vim.g.ruby_host_prog    = "C:\\tools\\ruby33\\bin\\ruby.exe"

else
  local python3 = vim.fn.exepath("python3")
  local python  = vim.fn.exepath("python")
  local ruby    = vim.fn.exepath("ruby")

  if python3 ~= "" then
    vim.g.python3_host_prog = python3
  else
    vim.notify("python3 not found in PATH!", vim.log.levels.ERROR)
  end

  if python ~= "" then
    vim.g.python_host_prog = python
  else
    vim.notify("python not found in PATH!", vim.log.levels.ERROR)
  end

  if ruby ~= "" then
    vim.g.ruby_host_prog = ruby
  else
    vim.notify("ruby not found in PATH!", vim.log.levels.ERROR)
  end
end
