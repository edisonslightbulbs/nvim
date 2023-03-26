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

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())


-- keybinds
local on_attach = function(client, bufnr)
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
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end

local lsp_flags = {
    debounce_text_changes = 150
}

local util = require('lspconfig.util')

-- cpp
lspconfig['clangd'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
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

-- python
lspconfig['pyright'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- flags = lsp_flags,
    autostart = true,
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


-- lua
lspconfig['lua_ls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    autostart = true,
    flags = lsp_flags,
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
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
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
