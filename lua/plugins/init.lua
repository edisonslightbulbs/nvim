local function plug()
    return require('packer').startup(function(use)
        -- packer
        use 'wbthomason/packer.nvim'

        -- theme
        use 'morhetz/gruvbox'
        use 'vim-airline/vim-airline'
        use 'kyazdani42/nvim-web-devicons'
        use 'vim-airline/vim-airline-themes'

        -- extensions
        use 'ervandew/supertab'
        use 'tpope/vim-fugitive'
        use 'nvim-lua/plenary.nvim'
        use 'voldikss/vim-floaterm'
        use 'google/vim-searchindex'
        use 'dstein64/vim-startuptime'
        use 'kyazdani42/nvim-tree.lua'
        use 'nvim-telescope/telescope.nvim'

        -- editting/formatting
        use 'tpope/vim-repeat'
        use 'tpope/vim-surround'
        use 'yggdroot/indentline'
        use 'raimondi/delimitmate'
        use 'Chiel92/vim-autoformat'

        -- intellisence
        use 'nvim-treesitter/nvim-treesitter'
        use 'williamboman/nvim-lsp-installer'
        use 'rafamadriz/friendly-snippets'
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'onsails/lspkind.nvim'
        use 'L3MON4D3/LuaSnip'
    end)
end

local function setup()
    --[[ For each plugin-setup module (listed below):
    Use pcalls (protected calls) to verify plugin state before
    executing setup commands. The pcalls run un-interrupted. If
    a plugin's state is erroraneous setup is not executed. ]]
    require('plugins.config.repeat')
    require('plugins.config.airline')
    require('plugins.config.bufonly')
    require('plugins.config.fugitive')
    require('plugins.config.nvimtree')
    require('plugins.custom.autosave')
    require('plugins.config.floatterm')
    require('plugins.config.telescope')
    require('plugins.config.indentline')
    require('plugins.config.autoformat')
    require('plugins.config.treesitter')
    require('plugins.config.lspinstaller')
    require('plugins.config.lspconfig')
    --require('plugins.config.supertab')
    require('plugins.config.luasnip')
    require('plugins.config.cmp')
end

-- local on_windows = vim.loop.os_uname().version:match 'Windows'
-- print(on_windows)
--
-- local function join_paths(...)
    --     local path_sep = on_windows and '\\' or '/'
    --     local result = table.concat({ ... }, path_sep)
    --     return result
    -- end
    --
    -- -- vim.cmd [[set runtimepath=$VIMRUNTIME]]
    -- -- print(runtimepath)
    --
    -- local temp_dir = vim.loop.os_getenv 'TEMP' or '/tmp'
    -- print(temp_dir)
    --
    -- vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))
    -- print(packpath)

    -- local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
    -- local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
    -- local compile_path = join_paths(install_path, 'plugin', 'packer_compiled.lua')
    --
    -- if vim.fn.isdirectory(install_path) == 0 then
    --     vim.fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
    -- end



    plug()
    -- require('packer').sync()
    setup()
