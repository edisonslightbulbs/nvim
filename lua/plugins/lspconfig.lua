-----------------------------------------------------------
-- LSP-CONFIG (runs after mason-lspconfig is loaded)     --
-----------------------------------------------------------
vim.lsp.set_log_level("error")

-- basic deps ---------------------------------------------------------------
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local mlsp           = require("mason-lspconfig")   -- already on rtp
if not ok_cmp then
  vim.notify("lspconfig: missing dependency cmp_nvim_lsp", vim.log.levels.ERROR)
  return
end

-- capabilities -------------------------------------------------------------
local capabilities = cmp_lsp.default_capabilities()

-- on-attach ---------------------------------------------------------------
local function on_attach(_, bufnr)
  local map = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true })
  end
  map("gd",        vim.lsp.buf.declaration)
  map("gdd",       vim.lsp.buf.definition)
  map("K",         vim.lsp.buf.hover)
  map("gi",        vim.lsp.buf.implementation)
  map("<space>rn", vim.lsp.buf.rename)
  map("<space>ca", vim.lsp.buf.code_action)
  map("<space>f",  function() vim.lsp.buf.format { async = true } end)
end

local flags = { debounce_text_changes = 150 }

-- make sure we have v≥1.1 API ---------------------------------------------
if not mlsp.setup_handlers then
  vim.notify("mason-lspconfig is too old — run :Lazy update", vim.log.levels.ERROR)
  return
end

-- handlers -----------------------------------------------------------------
mlsp.setup_handlers({

  -- default ---------------------------------------------------------------
  function(server)
    local opts = {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      root_dir     = function() return config.git.root() end,
    }
    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end,

  -- clangd ----------------------------------------------------------------
  ["clangd"] = function()
    local opts = {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--compile-commands-dir=" .. vim.fn.getcwd() .. "/build/Release",
      },
      -- root_dir will be taken from the default clangd config unless you
      -- explicitly override it here; previously you had no custom root_dir
      -- for clangd, so we keep that behavior.
    }
    vim.lsp.config("clangd", opts)
    vim.lsp.enable("clangd")
  end,

  -- lua_ls ---------------------------------------------------------------
  ["lua_ls"] = function()
    local opts = {
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
      root_dir = function() return config.git.root() end,
    }
    vim.lsp.config("lua_ls", opts)
    vim.lsp.enable("lua_ls")
  end,

  -- pyright --------------------------------------------------------------
  ["pyright"] = function()
    local opts = {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      settings = {
        python = {
          analysis = {
            extraPaths = { "" },
          },
        },
      },
      root_dir = function() return config.git.root() end,
    }
    vim.lsp.config("pyright", opts)
    vim.lsp.enable("pyright")
  end,

  -- cmake ----------------------------------------------------------------
  ["cmake"] = function()
    local opts = {
      capabilities = capabilities,
      on_attach    = on_attach,
      flags        = flags,
      root_dir     = function() return config.git.root() end,
    }
    vim.lsp.config("cmake", opts)
    vim.lsp.enable("cmake")
  end,

  -- jsonls ---------------------------------------------------------------
  ["jsonls"] = function()
    local opts = {
      capabilities = capabilities,
      on_attach    = on_attach,
      root_dir     = function() return config.git.root() end,
    }
    vim.lsp.config("jsonls", opts)
    vim.lsp.enable("jsonls")
  end,

  -- texlab ---------------------------------------------------------------
  ["texlab"] = function()
    local opts = {
      capabilities = capabilities,
      on_attach    = on_attach,
      root_dir     = function() return config.git.root() end,
    }
    vim.lsp.config("texlab", opts)
    vim.lsp.enable("texlab")
  end,
})
