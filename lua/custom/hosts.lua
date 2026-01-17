vim.g.loaded_ruby_provider = 0

-- Table for path functions and variables
_G.config = _G.config or {}
_G.config.host = {}

-- Determine the operating system using vim.loop.os_uname()
local os_name = vim.loop.os_uname().sysname

-- helpers -----------------------------------------------------------------
local function _join_path(a, b)
  if os_name == "Windows_NT" then
    return a .. "\\" .. b
  end
  return a .. "/" .. b
end

local function _venv_python3()
  local home = (os_name == "Windows_NT") and vim.env.USERPROFILE or vim.env.HOME
  if not home or home == "" then
    return ""
  end

  local venv_root = _join_path(home, ".venvs")
  local nvim_venv = _join_path(venv_root, "nvim")

  if os_name == "Windows_NT" then
    return _join_path(_join_path(nvim_venv, "Scripts"), "python.exe")
  end
  return _join_path(_join_path(nvim_venv, "bin"), "python")
end

local function _set_prog_or_warn(var_name, path, warn_msg)
  if path ~= "" and vim.fn.executable(path) == 1 then
    vim.g[var_name] = path
  else
    if warn_msg and warn_msg ~= "" then
      vim.notify(warn_msg, vim.log.levels.WARN)
    end
  end
end

-- python3 provider ---------------------------------------------------------
local venv_py3 = _venv_python3()
if venv_py3 ~= "" and vim.fn.executable(venv_py3) == 1 then
  vim.g.python3_host_prog = venv_py3
else
  local python3 = vim.fn.exepath("python3")
  if python3 ~= "" then
    vim.g.python3_host_prog = python3
  else
    local msg
    if os_name == "Windows_NT" then
      msg = table.concat({
        "python3 not found (and nvim venv missing). Create the provider venv:",
        "  py -3 -m venv %USERPROFILE%\\.venvs\\nvim",
        "  %USERPROFILE%\\.venvs\\nvim\\Scripts\\python.exe -m pip install -U pip pynvim",
      }, "\n")
    else
      msg = table.concat({
        "python3 not found (and nvim venv missing). Create the provider venv:",
        "  python3 -m venv ~/.venvs/nvim",
        "  ~/.venvs/nvim/bin/python -m pip install -U pip pynvim",
      }, "\n")
    end
    vim.notify(msg, vim.log.levels.ERROR)
  end
end

-- python (legacy provider, optional) --------------------------------------
local python = vim.fn.exepath("python")
if python ~= "" then
  vim.g.python_host_prog = python
else
  -- Keep the warning gentle: python2 provider is optional for most setups.
  vim.notify("python not found in PATH (python2 provider is optional).", vim.log.levels.WARN)
end

-- ruby provider (optional) ------------------------------------------------
-- local ruby = vim.fn.exepath("ruby")
-- if ruby ~= "" then
--   vim.g.ruby_host_prog = ruby
-- else
--   if os_name == "Windows_NT" then
--     -- keep your previous fallback path, but only if it exists
--     local ruby_fallback = "C:\\tools\\ruby33\\bin\\ruby.exe"
--     _set_prog_or_warn(
--       "ruby_host_prog",
--       ruby_fallback,
--       "ruby not found in PATH and fallback not found: " .. ruby_fallback
--     )
--   else
--     vim.notify("ruby not found in PATH!", vim.log.levels.WARN)
--   end
-- end

-- Use a dedicated venv for Neovim’s Python provider
--
-- Unix:
--      sudo apt update
--      sudo apt install -y python3-venv
--
--      python3 -m venv "$HOME/.venvs/nvim"
--      "$HOME/.venvs/nvim/bin/python" -m pip install --upgrade pip
--      "$HOME/.venvs/nvim/bin/python" -m pip install pynvim
--
-- Windows: (powershell)
--      py -3 -m venv "$env:USERPROFILE\.venvs\nvim"
--      & "$env:USERPROFILE\.venvs\nvim\Scripts\python.exe" -m pip install --upgrade pip
--      & "$env:USERPROFILE\.venvs\nvim\Scripts\python.exe" -m pip install pynvim
--
