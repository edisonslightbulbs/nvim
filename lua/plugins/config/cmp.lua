local status, ret = pcall(require, "cmp")
if not status then
    print("-- something went wrong while setting cmp!")
    return
end

status, ret = pcall(require, "lspkind")
if not status then
    print("-- something went wrong while setting upl spkind!")
    return
end

local cmp = require'cmp'
local lspkind = require('lspkind')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-j>'] = cmp.mapping.scroll_docs(-1),
        ['<C-k>'] = cmp.mapping.scroll_docs(1),
        --['<CR>'] = cmp.mapping.complete(),
        --['<ESCAPE>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        --{ name = 'git' },
        { name = 'nvim_lua' },
        { name = 'ultisnips' },
        { name = 'buffer', keyword_length = 5 },
    }),

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            menu = {
                nvim_lsp = "[lsp]",
                path = "[path]",
                git = "[git]",
                nvim_lua = "[lua]",
                ultisnips = "[snipp]",
                buffer = "[buf]",
            },
            -- maxwidth = 50,
            --before = function (entry, vim_item)
                --    return vim_item
                --end
                symbol_map = {
                    Text = "",
                    Method = "",
                    Function = "",
                    Constructor = "",
                    Field = "ﰠ",
                    Variable = "",
                    Class = "ﴯ",
                    Interface = "",
                    Module = "",
                    Property = "ﰠ",
                    Unit = "塞",
                    Value = "",
                    Enum = "",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "פּ",
                    Event = "",
                    Operator = "",
                    TypeParameter = ""
                },
            })
        },
    })

