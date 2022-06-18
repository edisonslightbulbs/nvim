"
" nvim path
"
if has('win32')
    let $nvim_path ='$HOME\AppData\Local\nvim'
else
    let $nvim_path ='$HOME/.config/nvim'
endif


"
" config runtime paths
"
if has('win32')
    source  $nvim_path\runtime.vim
else
    source  $nvim_path/runtime.vim
endif

"
" iff file changed outside of vim, auto read it again
"
set autoread

"
" preview window height
"
set previewheight=5

"
" encoding
"
set encoding=utf-8
scriptencoding utf-8

"
" use gui colors
"
set termguicolors

"
" use 256 terminal colors
"
set t_Co=256

"
" always show status
"
set laststatus=2

"
" enable syntax highlight
"
syntax on

"
" enable search highlight
"
set hlsearch
set incsearch

"
" enable cursor line
"
set cursorline

"
" indent rules
"
set cindent
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent

"
" detect file type
"
filetype indent on
filetype plugin on

"
" line wrap
"
set nowrap
set colorcolumn=65,80

"
" number line style
"
set relativenumber
set number
set number relativenumber

"
" cmd message height
"
set cmdheight=2

"
" abbreviate & truncate message
"
set shortmess=at


"
" silence
"
set visualbell
set t_vb=

"
" no backup files
"
set nobackup
set noswapfile
set nowritebackup

"
" split on RHS
"
set splitright

"
" ignore patterns
"
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class

"
" remove delay on ESC key-press
"
set timeoutlen=1000 ttimeoutlen=0

"
" setup spell
"
set spelllang=en_us,de_de spell
if has('win32')
    set spellfile=$nvim_path\spell\en.utf-8.add
else
    set spellfile=$nvim_path/spell/en.utf-8.add
endif


"
" custom binding
"
let g:binds=[
            \'keys.vim',
            \'augroups.vim']

for file in g:binds
    if has('win32')
        execute 'source ' .  $nvim_path . '\binds\' . file
    else
        execute 'source ' .  $nvim_path . '/binds/' . file
    endif
endfor

"
" plugins listed in plugged.vim && plugin config
"
if has('win32')
    execute 'source ' .  $nvim_path . '\plugged.vim'
else
    execute 'source ' .  $nvim_path . '/plugged.vim'
endif

let g:pluggedconfig=[
            \'gruvbox.vim',
            \'fzf.vim',
            \'fugitive.vim',
            \'floatterm.vim',
            \'nerdtree.vim',
            \'autoformat.vim',
            \'airline.vim',
            \'indentline.vim',
            \'rainbowparenth.vim',
            \'repeat.vim',
            \'gitgutter.vim',
            \'bufonly.vim',
            \'supertab.vim',
            \'youcompleteme.vim',
            \'ultisnipps.vim']

for file in g:pluggedconfig
    if has('win32')
        execute 'source ' .  $nvim_path . '\plugged-config\' . file
    else
        execute 'source ' .  $nvim_path . '/plugged-config/' . file
    endif
endfor

"
" my plugins
"
let g:dev=[
            \'helpers.vim',
            \'sandbox.vim',
            \'terminal.vim']

for file in g:dev
    if has('win32')
        execute 'source ' .  $nvim_path . '\plugged-dev\' . file
    else
        execute 'source ' .  $nvim_path . '/plugged-dev/' . file
    endif
endfor

" -- in revision
" repeat yanking with [.]
" set cpoptions+=y

" use clipboard for all yanking
" set clipboard=unnamedplus
