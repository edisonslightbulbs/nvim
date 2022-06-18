return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use 'tpope/vim-repeat'
    use 'ervandew/supertab'
    use 'honza/vim-snippets'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'yggdroot/indentline'
    use 'raimondi/delimitmate'
    use 'voldikss/vim-floaterm'
    use 'nvim-lua/plenary.nvim'
    use 'google/vim-searchindex'
    use 'Chiel92/vim-autoformat'
    use 'vim-airline/vim-airline'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-telescope/telescope.nvim'
    use 'vim-airline/vim-airline-themes'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)

-- in review
    --use 'dense-analysis/ale'
    --use 'SirVer/ultisnips'
    --use 'valloric/youcompleteme'
    --use 'scrooloose/nerdtree'

-- my plugins (... if I ever come around to finishing them)
    --use 'antiqueeverett/vim-undo'
    --use 'antiqueeverett/vim-cmake'
    --use 'antiqueeverett/vim-cursor'
    --use 'antiqueeverett/vim-autosave'
    --use 'antiqueeverett/vim-clipboard'
    --use 'antiqueeverett/vim-motion-tutor'
