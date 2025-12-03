local M = {}

local function health()
  return vim.health or require("vim.health")
end

local function report_module(name)
  local ok, err = pcall(require, name)
  if ok then
    health().report_ok(name .. " loaded")
  else
    health().report_error(name .. " failed: " .. err)
  end
  return ok
end

local function report_callable(name, fn)
  local ok, err = pcall(fn)
  if ok then
    health().report_ok(name .. " ok")
  else
    health().report_error(name .. " failed: " .. err)
  end
  return ok
end

function M.run()
  health().report_start("Seamless Neovim self-test")

  -- core requirements
  report_callable("Neovim version >= 0.10", function()
    if vim.fn.has("nvim-0.10") == 0 then
      error("Requires Neovim 0.10 or newer")
    end
  end)

  -- lazy bootstrap path sanity
  report_callable("lazy.nvim installed", function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if vim.fn.isdirectory(lazypath) == 0 then
      error("lazy.nvim not installed at " .. lazypath)
    end
  end)

  -- plugin loader
  if report_module("lazy") then
    health().report_ok("lazy.nvim runtime available")
  end

  -- critical plugins and configs that must load after sync
  report_module("mason")
  report_module("mason-lspconfig")
  report_module("cmp_nvim_lsp")
  report_module("nvim-treesitter.configs")
  report_module("nvim-tree")
  report_module("telescope")
  report_module("conform")

  -- configuration modules
  report_module("plugins.lspconfig")
  report_module("plugins.treesitter")
  report_module("plugins.cmp")
  report_module("plugins.nvimtree")

  health().report_ok("self-test completed")
end

return M
