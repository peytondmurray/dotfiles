-- Use spaces instead of tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true

vim.o.termguicolors = true

-- Diagnostic messaging
vim.o.signcolumn = 'yes'

-- Case sensitive searching only when caps used
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true

vim.o.number = true
vim.o.cursorline = true
vim.o.autoread = true
vim.o.wrap = false

vim.o.splitbelow = true
vim.o.splitright = true

-- Remove ~ at end of buffer
vim.o.fillchars = 'eob: '

-- Gitgutter
vim.g.SignatureMarkTextHLDynamic = 1

-- Use numpydoc docstrings
vim.g.pydocstring_formatter = 'numpy'
vim.g.pydocstring_doq_path = '~/.pyenv/shims/doq'

vim.o.background = "dark" -- or "light" for light mode

vim.o.foldmethod = 'expr'
vim.o.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
vim.o.foldenable = false

-- Show completion menu even if only one option is available; don't select by default
vim.o.completeopt = 'menuone,noselect'

-- Gdiffsplit opens vertically
vim.o.diffopt = vim.o.diffopt .. ',vertical'

vim.g.indentLine_char = '|'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.shortmess = 'I'

-- which-key
vim.o.timeoutlen = 500

-- Popups have pseudotransparency
vim.o.wildoptions='pum'
vim.o.pumblend = 20
vim.o.winblend = 20

vim.o.textwidth = 100

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

vim.g.nvim_tree_ignore = {
    '.git',
    'node_modules',
    '.cache',
    '__pycache__',
    '.pytest_cache',
    '.mypy_cache',
    '.ipynb_checkpoints',
}

vim.cmd('colorscheme gruvbox')
vim.cmd('highlight Vertsplit guifg=Orange')
vim.cmd('highlight illuminatedWord ctermbg=4 guibg=#233551')
vim.cmd('filetype plugin indent on')
vim.cmd([[autocmd BufWritePre * lua StripWhitespace()]])

-- Set textwidth for markdown and python
vim.cmd([[autocmd BufRead,BufNewFile *.md setlocal textwidth=80]])
vim.cmd([[autocmd BufRead,BufNewFile *.py setlocal textwidth=100]])
