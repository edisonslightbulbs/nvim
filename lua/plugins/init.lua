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
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
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

    --[[ Use protected calls (pcall) to load modules and check for errors.
         Modules required in this way are loaded without interruption, i.e.,
         regardless of propagated errors. If verification is unsuccessful,
         prevent further instructions from executing.
    ]]

    if not pcall(require, "nvim-treesitter.configs") then
        print("-- something went wrong while setting up treesitter!")
        return
    end

    if not pcall(require, "nvim-lsp-installer") then
        print("-- something went wrong while setting up nvim-lsp-installer!")
        return
    end

    if not pcall(require, "lspconfig") then
        print("-- something went wrong while setting up lspconfig!")
        return
    end

    if not pcall(require, "cmp") then
        print("-- something went wrong while setting cmp!")
        return
    end
end)
