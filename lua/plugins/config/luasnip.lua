local status, ret = pcall(require, "luasnip")
if not status then
    print("-- something went wrong while setting up luasnip!")
    return
end

-- use vs-code style snippets from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

require'luasnip'.filetype_extend("cpp", {"cpp"})

-- use custom snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "$HOME/.config/nvim/snipps/" } })
