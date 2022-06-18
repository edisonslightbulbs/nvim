if has('win32')
    call plug#begin('$HOME\AppData\Local\nvim\plugged')
else
    call plug#begin('$HOME/.config/nvim/plugged')
endif
" ----------------------------work-flow plugs---------------------------"
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'yggdroot/indentline'
Plug 'raimondi/delimitmate'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-gitgutter'
Plug 'google/vim-searchindex'
Plug 'Chiel92/vim-autoformat'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
" ----------------------------work-flow plugs---------------------------"


" -- in review
"Plug 'dense-analysis/ale'

" -- my plugins
"Plug 'antiqueeverett/vim-undo'
"Plug 'antiqueeverett/vim-cmake'
"Plug 'antiqueeverett/vim-cursor'
"Plug 'antiqueeverett/vim-autosave'
"Plug 'antiqueeverett/vim-clipboard'
"Plug 'antiqueeverett/vim-motion-tutor'
