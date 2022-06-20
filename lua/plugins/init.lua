return require('packer').startup(function()
    -- packer
    use 'wbthomason/packer.nvim'

    -- theme
    use 'morhetz/gruvbox'
    use 'google/vim-searchindex'
    use 'vim-airline/vim-airline'
    use 'kyazdani42/nvim-web-devicons'
    use 'vim-airline/vim-airline-themes'

    -- editting
    --use 'SirVer/ultisnips'
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

-- -- verify treesitter plugged correctly
-- local status, treesitter = pcall(require, "nvim-treesitter.configs")
-- if not status then
--     print("-- something went wrong while setting up treesitter!")
--     return
-- end
-- verify nvim-lsp-installer plugged correctly
-- local status, installer = pcall(require, "nvim-lsp-installer")
-- if not status then
--     print("-- something went wrong while setting up nvim-lsp-installer!")
--     return
-- end
---- verify lspconfig plugged correctly
--local status, config = pcall(require, "lspconfig")
--if not status then
--    print("-- something went wrong while setting up lspconfig!")
--    return
--end
---- verify cmp plugged correctly
--local status, cmp = pcall(require, "cmp")
--if not status then
--    print("-- something went wrong while setting cmp!")
--    return
--end
