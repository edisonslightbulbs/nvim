-----------------------------------------------------------
-- LSP-CONFIG (runs after mason-lspconfig is loaded)     --
-----------------------------------------------------------
vim.lsp.set_log_level("error")

local lspconfig = vim.lsp._config or vim.lsp.config
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")
if not lspconfig then
  local ok_legacy, legacy = pcall(require, "lspconfig")
  if ok_legacy then
    lspconfig = legacy
  else
    vim.notify("lspconfig: missing dependency", vim.log.levels.ERROR)
    return
  end
end
if not ok_mlsp then
  vim.notify("lspconfig: mason-lspconfig not available", vim.log.levels.ERROR)
  return
end
if not ok_cmp then
  vim.notify("lspconfig: missing cmp_nvim_lsp", vim.log.levels.ERROR)
  return
end

-- capabilities -------------------------------------------------------------
local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- on-attach ---------------------------------------------------------------
local function on_attach(_, bufnr)
  local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true }) end
  map("gd",  vim.lsp.buf.declaration)
  map("gdd", vim.lsp.buf.definition)
  map("K",   vim.lsp.buf.hover)
  map("gi",  vim.lsp.buf.implementation)
  map("<space>rn", vim.lsp.buf.rename)
  map("<space>ca", vim.lsp.buf.code_action)
  map("<space>f",  function() vim.lsp.buf.format { async = true } end)
end
local flags = { debounce_text_changes = 150 }

local function git_root_or_cwd()
  local ok_git = type(config) == "table" and config.git and config.git.root
  return (ok_git and config.git.root()) or vim.loop.cwd()
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
    lspconfig[server].setup {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      root_dir     = git_root_or_cwd,
    }
  end,

  -- clangd ----------------------------------------------------------------
  ["clangd"] = function()
    lspconfig.clangd.setup {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build/Release",
      },
    }
  end,

  -- lua_ls ---------------------------------------------------------------
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup {
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
      root_dir = git_root_or_cwd,
    }
  end,

  -- pyright --------------------------------------------------------------
  ["pyright"] = function()
    lspconfig.pyright.setup {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      settings = { python = { analysis = { extraPaths = { "" } } } },
      root_dir = git_root_or_cwd,
    }
  end,

  -- cmake ----------------------------------------------------------------
  ["cmake"] = function()
    lspconfig.cmake.setup {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      root_dir = git_root_or_cwd,
    }
  end,

  -- jsonls ---------------------------------------------------------------
  ["jsonls"] = function()
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      on_attach    = on_attach,
      root_dir = git_root_or_cwd,
    }
  end,

  -- texlab ---------------------------------------------------------------
  ["texlab"] = function()
    lspconfig.texlab.setup {
      capabilities = capabilities,
      on_attach    = on_attach,
      root_dir = git_root_or_cwd,
    }
  end,
})
