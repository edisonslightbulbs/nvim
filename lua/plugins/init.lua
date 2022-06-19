return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- theme
    use 'morhetz/gruvbox'
    use 'google/vim-searchindex'
    use 'vim-airline/vim-airline'
    use 'kyazdani42/nvim-web-devicons'
    use 'vim-airline/vim-airline-themes'

    -- editting
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
end)

-- in review
--use 'SirVer/ultisnips'
--use 'valloric/youcompleteme'

-- my plugins (... if I ever come around to finishing them)
--use 'antiqueeverett/vim-undo'
--use 'antiqueeverett/vim-cmake'
--use 'antiqueeverett/vim-cursor'
--use 'antiqueeverett/vim-autosave'
--use 'antiqueeverett/vim-motion-tutor'
