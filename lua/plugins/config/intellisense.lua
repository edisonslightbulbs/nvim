-- check nvim-lsp-installer and lspconfig AOT
local status, installer = pcall(require, "nvim-lsp-installer")
if not status then
    print("-- something went wrong while setting up nvim-lsp-installer!")
    return
end

local status, config = pcall(require, "lspconfig")
if not status then
    print("-- something went wrong while setting up lspconfig!")
    return
end


-- setup nvim-lsp-installer and lspconfig
require("nvim-lsp-installer").setup {
    automatic_installation = true, -- detect and install servers
    ui = {
        icons = {
            server_installed = "",
            server_pending = "",
            server_uninstalled = ""
        }
    }
}

local function on_attach(client, bufnr)
    print("set up buffer keymaps, etc")
end
local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup { on_attach = on_attach }
