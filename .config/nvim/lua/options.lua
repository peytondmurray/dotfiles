-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true

vim.o.termguicolors = true

-- Disable "Press Enter to continue nag alerts"
vim.o.cmdheight = 2

-- Diagnostic messaging
vim.o.signcolumn = 'yes'

-- Case sensitive searching only when caps used
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.autoread = true
vim.o.wrap = false

vim.o.splitbelow = true
vim.o.splitright = true

-- Remove ~ at end of buffer
vim.o.fillchars = 'eob: '

vim.o.scrolloff = 5

-- Gitgutter
vim.g.SignatureMarkTextHLDynamic = 1

-- Use numpydoc docstrings
vim.g.pydocstring_enable_mapping = false
vim.g.pydocstring_formatter = 'numpy'
vim.g.pydocstring_doq_path = '~/.pyenv/shims/doq'

vim.o.background = "dark" -- or "light" for light mode
-- vim.o.background = "light" -- or "light" for light mode
vim.g.tokyonight_style = "day" -- or "light" for light mode

-- Show completion menu even if only one option is available; don't select by default
vim.o.completeopt = 'menuone,noselect,preview'
vim.o.wildmenu = true
vim.o.wildmode = 'longest:full,full'

-- Gdiffsplit opens vertically
vim.o.diffopt = vim.o.diffopt .. ',vertical'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.shortmess = 'IFa'

-- which-key
vim.o.timeoutlen = 500

-- Popups have pseudotransparency
vim.o.wildoptions='pum'
vim.o.pumblend = 20
vim.o.winblend = 20

vim.o.textwidth = 100

-- Don't redraw the window when executing commands that haven't been typed
vim.g.lazyredraw = true

-- Firenvim
vim.g.firenvim_config = {
    globalSettings = {alt = 'all'},
    localSettings = {
        ['.*'] = {
            cmdline = 'neovim',
            content = 'text',
            priority = 0,
            selector = 'textarea',
            takeover = 'never',
        },
    }
}

vim.g.kommentary_create_default_mappings = false

-- vim.cmd('colorscheme tokyonight')
vim.cmd('colorscheme nightfox')
-- vim.cmd('colorscheme gruvbox')
vim.cmd('highlight Vertsplit guifg=Orange')
vim.cmd('filetype plugin indent on')
vim.api.nvim_create_autocmd("BufWritePre", { callback = require('luautils').StripWhitespace })

-- Set textwidth for markdown and python
vim.api.nvim_create_autocmd("BufRead,BufNewFile", { command = "setlocal textwidth=80", pattern = "*.md" })
vim.api.nvim_create_autocmd("BufRead,BufNewFile", { command = "setlocal textwidth=100", pattern = "*.py" })
vim.api.nvim_create_autocmd("BufRead,BufNewFile", { command = "setlocal tabstop=2 shiftwidth=2", pattern = {"*.ts", "*.js", "*.tsx", "*.jsx", "*.html.j2", "*.html", "*.css", "*.json"} })
vim.api.nvim_create_autocmd("BufRead,BufNewFile", { command = "set filetype=htmldjango", pattern = {"*.html.j2"} })

-- Format json on save; strip trailing comma
vim.api.nvim_create_autocmd("BufWritePre", { command = [[%!jq -n -f /dev/stdin]], pattern = {"*.json"} })

-- disable builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.g.doge_enable_mappings = false
vim.g.doge_doc_standard_python = 'numpy'

vim.o.laststatus = 3

vim.o.winbar = '%f'

vim.wo.foldcolumn = '1'
vim.wo.foldlevel = 99
vim.wo.foldenable = true

vim.g.loaded_python3_provider = 0
