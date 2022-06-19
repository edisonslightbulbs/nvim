-- check nvim-lsp-installer, lspconfig, and cmp AOT
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

local status, engine = pcall(require, "cmp")
if not status then
    print("-- something went wrong while setting cmp!")
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


-- setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
    --snippet = {
    --    -- REQUIRED - you must specify a snippet engine
    --    expand = function(args)
    --        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    --        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    --        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    --        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    --    end,
    --},
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
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
    capabilities = capabilities
}
