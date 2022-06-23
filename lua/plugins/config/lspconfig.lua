local status, ret = pcall(require, "lspconfig")
if not status then
    print("-- something went wrong while setting up lspconfig!")
    return
end


-- keybinding
local function on_attach(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
require('lspconfig')['sumneko_lua'].setup{
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- server
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim', 'cmp'},
            },
            workspace = {
                -- runtime paths
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- disable sending telemetry data
            telemetry = {
                enable = false,
            },
        },
    },
}

-- python
local util = require("lspconfig/util")
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,

    settings = {
        python = {
            analysis = {
                extraPaths = {""}
            }
        }
    },

    root_dir = function(fname)
        return util.root_pattern(
        ".git",
        "setup.py",
        "setup.cfg",
        "pyproject.toml",
        "pyrightconfig.json",
        "requirements.txt")(fname) or
        util.path.dirname(fname)
    end
}

