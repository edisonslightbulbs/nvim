local settings = {
    -- file handling
    autoread = true,         -- auto read ext. modified files
    backup = false,          -- create backup files
    swapfile = false,        -- create swap files
    fileencoding = "utf-8",  -- encoding for written files

    -- ignore patterns
    wildignore = "*.swp, *.bak, *.pyc, *.class, *.metainfo",

    -- windowing
    previewheight = 5,       -- preview-window height
    splitright = true,       -- split right

    -- editing
    smartindent = true,      -- smart auto-indenting for c programs
    autoindent = true,       -- indent on new line
    expandtab = true,        -- use spaces on <Tab>
    cindent = true,          -- use c program indent rules
    shiftwidth = 4,          -- number of spaces used for indenting
    tabstop = 4,             -- number of spaces used on <Tab>

    -- editor
    relativenumber = true,   -- enable relative numbers
    concealcursor = "n",     -- conceal in cursor mode iff in [n] mode
    signcolumn = "yes",      -- show sign column
    cursorline = true,       -- enable cursor line
    showtabline = 2,         -- show tabs (do I need this?)
    number = true,           -- enable numbers
    mouse = "a",             -- enable mouse
    wrap = true,             -- wrap @ line 80

    -- status line
    --laststatus = 2,          -- show status
    --cmdheight = 2,           -- cmd message height
    wildmenu = true,         -- use menu for cmd-line completions
    --shortmess = "at",        -- file messages based on args [a, t]

    -- search
    incsearch = true,        -- highlight match while typing
    hlsearch = true,         -- enable search highlight
    ignorecase = false,      -- ignore case in search patterns

    -- sound
    visualbell = true,       -- silence

    -- timeout
    timeoutlen = 1000,       -- timeout (ms) for a mapped sequence completions
    ttimeoutlen = 0,         -- timeout (ms) on ESC key-press
}

for k, v in pairs(settings) do
    vim.opt[k] = v
end

vim.cmd [[set iskeyword+=-]]           -- add '-' to  keyword match
vim.cmd [[set whichwrap+=<,>[,],h,l]]  -- allow wrapping with keys
