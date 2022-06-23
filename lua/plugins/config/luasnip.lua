local status, ret = pcall(require, "luasnip")
if not status then
    print("-- something went wrong while setting up luasnip!")
    return
end

require("luasnip.loaders.from_vscode").lazy_load()

