local settings = {
    -- file handling
    autoread = true,                -- auto read ext. modified files
    backup = false,                 -- create backup files
    writebackup = false,            -- create backup before writing a file
    swapfile = false,                -- create swap files
    encoding = 'utf-8',             -- encoding
    fileencoding = 'utf-8',         -- encoding for written files

    -- ignore patterns
    wildignore = '*.swp, *.bak, *.pyc, *.class, *.metainfo *.lock',

    -- windowing
    previewheight = 5,              -- preview-window height
    splitright = true,              -- split right

    -- editing
    smartindent = true,             -- smart auto-indenting for c programs
    autoindent = true,              -- indent on new line
    expandtab = true,               -- use spaces on <Tab>
    cindent = true,                 -- use c program indent rules
    shiftwidth = 4,                 -- number of spaces used for indenting
    tabstop = 4,                    -- number of spaces used on <Tab>

    -- editor
    relativenumber = true,          -- enable relative numbers
    signcolumn = 'yes',             -- show sign column
    cursorline = true,              -- enable cursor line
    showtabline = 2,                -- show tabs (do I need this?)
    number = true,                  -- enable numbers
    mouse = 'a',                    -- enable mouse
    wrap = true,                    -- wrap @ line 80
    foldenable = false,             -- disable folding

    --spell
    spell = true,                   -- check spellings
    spellcapcheck= '',              -- no cap check
    spelllang = 'en_us,de_de',   -- spell language
    spellfile = config.path.join(vim.fn.stdpath('config'), 'spell', 'spellings.utf-8.add'),

    -- status line
    laststatus = 2,                 -- show status
    cmdheight = 3,                  -- cmd message height
    wildmenu = true,                -- use menu for cmd-line completions
    shortmess = 'at',               -- file messages based on args [a, t]

    -- search
    incsearch = true,               -- highlight match while typing
    hlsearch = true,                -- enable search highlight
    ignorecase = false,             -- ignore case in search patterns

    -- sound
    visualbell = true,              -- silence

    -- timeout
    timeoutlen = 1000,              -- timeout (ms) for a mapped sequence completions
    ttimeoutlen = 0,                -- timeout (ms) on ESC key-press
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end

vim.cmd([[ set clipboard+=unnamedplus ]]) -- clipboard
vim.cmd([[ set iskeyword+=- ]])           -- match `-` in words
vim.cmd([[ set whichwrap+=<,>[,],h,l ]])  -- allow wrapping with keys

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup undodir
local undodir = config.path.join(vim.fn.stdpath('config'), 'autosave', 'undo')
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end

vim.opt.undodir = undodir
vim.opt.undofile = true

require('settings.auto')
require('settings.hosts')
require('settings.theme')
