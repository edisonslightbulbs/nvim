-- bootstrapping
--[[ @todo:
        buggy chunk ]]
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- packer
    use 'wbthomason/packer.nvim'

    -- theme
    use 'morhetz/gruvbox'
    use 'google/vim-searchindex'
    use 'vim-airline/vim-airline'
    use 'kyazdani42/nvim-web-devicons'
    use 'vim-airline/vim-airline-themes'

    -- editting
    use 'SirVer/ultisnips'
    use 'tpope/vim-repeat'
    use 'ervandew/supertab'
    use 'honza/vim-snippets'
    use 'tpope/vim-surround'

    -- extensions
    use 'tpope/vim-fugitive'
    use 'nvim-lua/plenary.nvim'
    use 'voldikss/vim-floaterm'
    use 'kyazdani42/nvim-tree.lua'
    use 'nvim-telescope/telescope.nvim'

    -- formatting
    use 'yggdroot/indentline'
    use 'raimondi/delimitmate'
    use 'Chiel92/vim-autoformat'

    -- intellisence
    use 'nvim-treesitter/nvim-treesitter'
    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- boostrapping
    if packer_bootstrap then
        require('packer').sync()
    end

    --[[ Use protected calls (pcall) to load each module and check for errors.
    Modules required in this way are loaded without interruption, regardless
    of errors. If verification is unsuccessful, stop further execution. ]]
    require('plugins.config.repeat')
    require('plugins.config.airline')
    require('plugins.config.bufonly')
    require('plugins.config.fugitive')
    require('plugins.config.supertab')
    require('plugins.config.nvimtree')
    require('plugins.config.ultisnipps')
    require('plugins.config.floatterm')
    require('plugins.config.telescope')
    require('plugins.config.indentline')
    require('plugins.config.autoformat')
    require('plugins.config.treesitter')
    require('plugins.config.intellisense')
    require('plugins.custom.autosave')
end)
