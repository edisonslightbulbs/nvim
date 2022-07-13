local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
    print('-- something went wrong while setting up lspconfig!')
    return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then
    print('-- something went wrong while setting up cmp_nvim_lsp!')
    return
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- keybinds
local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)
end

-- lua
lspconfig['sumneko_lua'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim', 'cmp' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- python
local util = require('lspconfig.util')
lspconfig['pyright'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                extraPaths = { '' },
            },
        },
    },
    root_dir = function(fname)
        return util.root_pattern(
            '.git',
            'setup.py',
            'setup.cfg',
            'pyproject.toml',
            'pyrightconfig.json',
            'requirements.txt'
        )(fname) or util.path.dirname(fname)
    end,
})

-- cpp
lspconfig['clangd'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function(fname)
        return util.root_pattern(
            '.git',
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac'
        )(fname) or util.path.dirname(fname)
    end,
})

--json
lspconfig['jsonls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- root_dir = function(fname)
    --     return util.root_pattern(
    --         '.git',
    --         '.clangd',
    --         '.clang-tidy',
    --         '.clang-format',
    --         'compile_commands.json',
    --         'compile_flags.txt',
    --         'configure.ac'
    --     )(fname) or util.path.dirname(fname)
    -- end,
})

