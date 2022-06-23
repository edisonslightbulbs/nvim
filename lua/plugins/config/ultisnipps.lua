local status, ret = pcall(require, "cmp_nvim_ultisnips")
if not status then
    print("-- something went wrong while setting up cmp_nvim_ultisnips!")
    return
end


require("cmp_nvim_ultisnips").setup {
    filetype_source = "treesitter",
    show_snippets = "all",
    documentation = function(snippet)
        return snippet.description
    end
}




-- local config = function()
--     local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
--     require("cmp").setup({
--         snippet = {
--             expand = function(args)
--                 vim.fn["UltiSnips#Anon"](args.body)
--             end,
--         },
--         sources = {
--             { name = "ultisnips" },
--             -- more sources
--         },
--         -- recommended configuration for <Tab> people:
--         mapping = {
--             ["<Tab>"] = cmp.mapping(
--             function(fallback)
--                 cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
--             end,
--             { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
--             ),
--             ["<S-Tab>"] = cmp.mapping(
--             function(fallback)
--                 cmp_ultisnips_mappings.jump_backwards(fallback)
--             end,
--             { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
--             ),
--         },
--     })
-- end
