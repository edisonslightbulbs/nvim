local status, ret = pcall(require, "lspconfig")
    if not status then
        print("-- something went wrong while setting up lspconfig!")
        return
    end

local function on_attach(client, bufnr)
    print("set up buffer keymaps, etc")
end
local lspconfig = require("lspconfig")
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
}
