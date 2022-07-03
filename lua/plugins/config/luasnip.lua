local status, ret = pcall(require, "luasnip")
if not status then
    print("-- something went wrong while setting up luasnip!")
    return
end

-- load existing snippets from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
require "luasnip".filetype_extend("cpp", {"cpp"})

-- load custom snippets
local snippets = JoinPath(vim.fn.stdpath("config"), "snipps")
require("luasnip.loaders.from_vscode").lazy_load({paths = {snippets}})
