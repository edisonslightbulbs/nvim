local status, luasnip = pcall(require, "luasnip")
if not status then
	print("-- something went wrong while setting up luasnip!")
	return
end

local snippets = config.path.join(vim.fn.stdpath("config"), "snipps")
local loader = require("luasnip.loaders.from_vscode")

-- load cpp snippets from rafamadriz/friendly-snippets
loader.lazy_load()
luasnip.filetype_extend("cpp", { "cpp" })

-- load custom snippets
loader.lazy_load({ paths = { snippets } })
