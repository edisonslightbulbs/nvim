local status, ret = pcall(require, "cmp")
if not status then
    print("-- something went wrong while setting cmp!")
    return
end

local cmp = require'cmp'
cmp.setup({
    snippet = {
        -- snippet engines
        expand = function(args)
            --require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
        ['<ESCAPE>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        --{ name = 'luasnip' },
        { name = 'ultisnips' },
    }, {
        { name = 'buffer' },
    })
})


-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim"},
            },
        },
    },
}
