-----------------------------------------------------------
-- LSP-CONFIG (runs after mason-lspconfig is loaded)     --
-----------------------------------------------------------
vim.lsp.set_log_level("error")

-- basic deps ---------------------------------------------------------------
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local mlsp            = require("mason-lspconfig")   -- already on rtp
if not ok_cmp then
  vim.notify("lspconfig: missing dependency", vim.log.levels.ERROR)
  return
end

-- native-only (Neovim 0.11+) ----------------------------------------------
local function setup_server(server_name, server_config)
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end

-- capabilities -------------------------------------------------------------
local capabilities = cmp_lsp.default_capabilities()

-- Disable LSP "watched files" dynamic registration to prevent Neovim's native fs watcher
-- from trying to watch protected/system paths on Windows (e.g. C:\Windows\Temp) and erroring with EPERM.
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = capabilities.workspace.didChangeWatchedFiles or {}
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false


-- on-attach ---------------------------------------------------------------
local function on_attach(_, bufnr)
  local map = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("gd",        vim.lsp.buf.definition)
  map("gD",        vim.lsp.buf.declaration)
  map("K",         vim.lsp.buf.hover)
  map("gi",        vim.lsp.buf.implementation)
  map("<space>rn", vim.lsp.buf.rename)
  map("<space>ca", vim.lsp.buf.code_action)
  map("<space>f",  function() vim.lsp.buf.format { async = true } end)
end

local flags = { debounce_text_changes = 150 }

-- root_dir helpers (Neovim 0.11+ signature: (bufnr, on_dir)) ---------------
local function call_on_dir(on_dir, dir)
  if type(dir) == "string" and dir ~= "" then
    on_dir(dir)
    return true
  end
  return false
end

local function git_root_dir(bufnr, on_dir)
  local ok_root, root = pcall(function()
    if config and config.git and config.git.root then
      return config.git.root()
    end
    return nil
  end)

  if ok_root and call_on_dir(on_dir, root) then
    return
  end

  local fname = vim.api.nvim_buf_get_name(bufnr)
  if type(fname) == "string" and fname ~= "" then
    local parent = vim.fs.dirname(fname)
    if call_on_dir(on_dir, parent) then
      return
    end
  end

  on_dir(vim.fn.getcwd())
end

-- python env resolution (conda-aware) --------------------------------------
local uv = vim.uv or vim.loop

local function is_windows()
  return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
end

local function is_executable(path)
  return type(path) == "string" and path ~= "" and vim.fn.executable(path) == 1
end

local conda_warned = false

local function resolve_python_path()
  local conda_prefix = vim.env.CONDA_PREFIX
  if type(conda_prefix) == "string" and conda_prefix ~= "" then
    local candidate = nil

    if is_windows() then
      candidate = vim.fs.joinpath(conda_prefix, "python.exe")
      if not is_executable(candidate) then
        candidate = vim.fs.joinpath(conda_prefix, "Scripts", "python.exe")
      end
    else
      candidate = vim.fs.joinpath(conda_prefix, "bin", "python")
    end

    if is_executable(candidate) then
      return candidate
    end

    if not conda_warned then
      conda_warned = true
      vim.notify(
        "pyright: CONDA_PREFIX is set but no python executable was found under it; falling back to system python",
        vim.log.levels.WARN
      )
    end
  end

  local python = vim.fn.exepath("python3")
  if python == "" then
    python = vim.fn.exepath("python")
  end

  if python ~= "" and (not uv or not uv.fs_stat or uv.fs_stat(python)) then
    return python
  end

  return nil
end

local function pyright_root_dir(bufnr, on_dir)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if type(fname) == "string" and fname ~= "" then
    local root = vim.fs.root(fname, {
      "pyrightconfig.json",
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "environment.yml",
      "conda.yaml",
      ".git",
    })

    if call_on_dir(on_dir, root) then
      return
    end
  end

  git_root_dir(bufnr, on_dir)
end

-- make sure we have v≥1.1 API ---------------------------------------------
if not mlsp.setup_handlers then
  vim.notify("mason-lspconfig is too old — run :Lazy update", vim.log.levels.ERROR)
  return
end

-- handlers -----------------------------------------------------------------
mlsp.setup_handlers({

  -- default ---------------------------------------------------------------
  function(server)
    setup_server(server, {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      root_dir     = git_root_dir,
    })
  end,

  -- clangd ----------------------------------------------------------------
  ["clangd"] = function()
    setup_server("clangd", {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build/Release",
      },
    })
  end,

  -- lua_ls ---------------------------------------------------------------
  ["lua_ls"] = function()
    setup_server("lua_ls", {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      settings = {
        Lua = {
          runtime      = { version = "LuaJIT" },
          diagnostics  = { globals = { "vim", "cmp" } },
          workspace    = { checkThirdParty = false },
          telemetry    = { enable = false },
        },
      },
      root_dir = git_root_dir,
    })
  end,

  -- pyright --------------------------------------------------------------
  ["pyright"] = function()
    local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
    local pyright_bin = is_windows() and "pyright-langserver.cmd" or "pyright-langserver"

    setup_server("pyright", {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      cmd = { vim.fs.joinpath(mason_bin, pyright_bin), "--stdio" },
      before_init = function(_, cfg)
        cfg.settings = cfg.settings or {}
        cfg.settings.python = cfg.settings.python or {}

        -- Respect an explicit user override.
        if type(cfg.settings.python.pythonPath) == "string" and cfg.settings.python.pythonPath ~= "" then
          return
        end

        local python_path = resolve_python_path()
        if python_path then
          cfg.settings.python.pythonPath = python_path
        else
          vim.notify("pyright: could not resolve any python interpreter path", vim.log.levels.WARN)
        end
      end,
      settings = {
        python = {
          analysis = {
            extraPaths = { "" },
          },
        },
      },
      root_dir = pyright_root_dir,
    })
  end,

  -- cmake ----------------------------------------------------------------
  ["cmake"] = function()
    setup_server("cmake", {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      root_dir = git_root_dir,
    })
  end,

  -- jsonls ---------------------------------------------------------------
  ["jsonls"] = function()
    setup_server("jsonls", {
      capabilities = capabilities,
      on_attach    = on_attach,
      root_dir = git_root_dir,
    })
  end,

  -- texlab ---------------------------------------------------------------
  ["texlab"] = function()
    setup_server("texlab", {
      capabilities = capabilities,
      on_attach    = on_attach,
      root_dir = git_root_dir,
    })
  end,
})
