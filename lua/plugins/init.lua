local run_packer_sync = false
local target = join_path(vim.fn.stdpath('data'), 'site', 'pack', 'packer', 'start', 'packer.nvim')

if vim.fn.isdirectory(target) == 0 then
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', target })
    vim.api.nvim_command('packadd packer.nvim')
    run_packer_sync = true
end

local packer_status, packer = pcall(require, 'packer')
if not packer_status then
    print('-- something went wrong while setting up packer!')
    print('-- skipping plugin config and bailing out!')
    return
end
-- vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath


local function plug()
    return require('packer').startup(function(use)
        -- packer
        use('wbthomason/packer.nvim')

        -- theme
        use('morhetz/gruvbox')
        use('vim-airline/vim-airline')
        use('kyazdani42/nvim-web-devicons')
        use('vim-airline/vim-airline-themes')

        -- extensions
        use('tpope/vim-fugitive')
        use('nvim-lua/plenary.nvim')
        use({ 'akinsho/toggleterm.nvim', tag = 'v2.*' })
        use('google/vim-searchindex')
        use('dstein64/vim-startuptime')
        use('kyazdani42/nvim-tree.lua')
        use('nvim-telescope/telescope.nvim')

        -- editing/formatting
        use('tpope/vim-repeat')
        use('tpope/vim-surround')
        use('yggdroot/indentline')
        use('raimondi/delimitmate')
        use('jose-elias-alvarez/null-ls.nvim')

        -- intellisence
        use('nvim-treesitter/nvim-treesitter')
        use('williamboman/nvim-lsp-installer')
        use('rafamadriz/friendly-snippets')
        use('neovim/nvim-lspconfig')
        use('hrsh7th/nvim-cmp')
        use('hrsh7th/cmp-path')
        use('hrsh7th/cmp-buffer')
        use('hrsh7th/cmp-cmdline')
        use('hrsh7th/cmp-nvim-lsp')
        use('onsails/lspkind.nvim')
        use('L3MON4D3/LuaSnip')
    end)
end

local function conf()
    --[[ For each plugin-setup module (listed below):
    Use pcalls (protected calls) to verify plugin state before
    executing setup commands. The pcalls run un-interrupted. If
    a plugin's state is erroneous setup is not executed. ]]
    require('plugins.setup.repeat')
    require('plugins.setup.airline')
    require('plugins.setup.fugitive')
    require('plugins.setup.nvimtree')
    require('plugins.setup.telescope')
    require('plugins.setup.indentline')
    require('plugins.setup.treesitter')
    require('plugins.setup.toggleterm')
    require('plugins.setup.lspinstaller')
    require('plugins.setup.lspconfig')
    require('plugins.setup.surround')
    require('plugins.setup.luasnip')
    require('plugins.setup.null-ls')
    require('plugins.setup.cmp')
    require('plugins.setup.gruvbox')
    require('plugins.custom.smart-buf')
    require('plugins.custom.autosave')
end

local plug_status, massage = pcall(plug)
if plug_status then
    if run_packer_sync then
        require('packer').sync()
    end
end

local conf_status, massage = pcall(conf)
