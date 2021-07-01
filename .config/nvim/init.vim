" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'kshenoy/vim-signature'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'rrethy/vim-illuminate'
Plug 'guns/xterm-color-table.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'raimondi/delimitmate'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lukhio/vim-mapping-conflicts'
Plug 'folke/which-key.nvim'

" LaTeX live preview
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Debugging
Plug 'puremourning/vimspector'

" Autoformatting
Plug 'Chiel92/vim-autoformat'

" Convenient window swapping
Plug 'wesq3/vim-windowswap'

" Fix CursorHold performance
Plug 'antoinemadec/FixCursorHold.nvim'

" File explorer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-git-status.vim'

" Color any RGB colors
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Themes
Plug 'ayu-theme/ayu-vim'
Plug 'morhetz/gruvbox'
Plug 'ronny/birds-of-paradise.vim'
Plug 'jacoborus/tender.vim'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Initialize plugin system
call plug#end()

syntax enable
set termguicolors

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
"let g:airline_theme = 'gruvbox'
let ayucolor="dark"
colorscheme ayu

highlight illuminatedWord ctermbg=4 guibg=#233551

" Highlight colors
let g:Hexokinase_highlighters = ['virtual']

" Python and node paths
let g:python3_host_prog = expand('~/.pyenv/versions/3.9.1/bin/python')
let g:node_host_prog = expand('~/.nvm/versions/node/v15.6.0/bin/neovim-node-host')

" Instant markdown
filetype plugin indent on

" Diagnostic messaging
set signcolumn=yes

" Case sensitive searching only when caps used
set ignorecase
set smartcase
set inccommand="nosplit"
set incsearch

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab

" Map alt+. to repeat last macro
:map <M-.> @@

" Fix writing to buffer all the time
let g:cursorhold_updatetime = 100

" Control+/ to toggle comment status
imap <C-_> <Esc><plug>NERDCommenterTogglei
vmap <C-_> <plug>NERDCommenterTogglegbv
nmap <C-_> <plug>NERDCommenterToggle

" Override JS
let g:NERDCustomDelimiters = { 'javascript': { 'left': '// ' } }

" Show line numbers
set number

" Highlight current cursor line
set cursorline

" Automatically update when the current file changes on disk
set autoread

" Don't wrap long lines
set nowrap

"Remap docstring lookup to ctrl-shift-/
nnoremap <BS> K

" Shift+HJKL to move a lot in normal mode
nnoremap J 30j
nnoremap K 30k
vnoremap J 30j
vnoremap K 30k

" Ctrl+HJKL to move between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ctrl+Alt+HJKL to resize windows
nnoremap <M-C-J> <C-W>20-
nnoremap <M-C-K> <C-W>20+
nnoremap <M-C-L> <C-W>20>
nnoremap <M-C-H> <C-W>20<

" Make splits more sensible
set splitbelow
set splitright

" Make orange bar for vertical splits
highlight VertSplit guifg=Orange

" Remove tildes at the end of the buffer
let &fcs='eob: '

nnoremap <SPACE> <Nop>
let mapleader=" "

" Strip trailing whitespace on save; remove blank line at end of file
function BeforeSave()
    :%s/\s\+$//e
    :%s/\($\n\s*\)\+\%$//e
endfunction

autocmd BufWritePre * call BeforeSave()
" Ctrl+BS to delete word backwards
imap <C-BS> <C-w>
imap  <C-w>

" Clear last search highlighting
nmap <silent> <M-/> :let @/=""<CR>

" Make ; start ripgrep
nmap <leader>; :Rg<CR>
nmap <leader>p :Files<CR>

" Tab/Shift+Tab to indent/dedent
imap <S-Tab> <C-d>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Make s act like d, except it won't save anything to the register
nnoremap s "_d

" Alt+JK to move line down/up by one row
nmap <M-j> :m+1<CR>
nmap <M-k> :m-2<CR>

" fzf support
set rtp+=/home/pdmurray/.fzf/bin/fzf

" Show marks, but inherit color from gitgutter
let g:SignatureMarkTextHLDynamic = 1

" Use numpydoc docstrings
let g:pydocstring_formatter = 'numpy'
let g:pydocstring_doq_path = '~/.pyenv/shims/doq'
nmap <leader>d <Plug>(pydocstring)

" Disable Ultisnips keybindings
let g:UltiSnipsExpandTrigger = "<NUL>"
let g:UltiSnipsListSnippets = "<NUL>"
let g:UltiSnipsJumpForwardTrigger = "<NUL>"
let g:UltiSnipsJumpBackwardTrigger = "<NUL>"

" LSP Config
lua << EOF
local nvim_lsp = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

-- LSP keybinds
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>v', '<cmd>vs<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>sp<cr><cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>u', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>y', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

nvim_lsp["pylsp"].setup{
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150
    },
    cmd = { 'pylsp', '-vvv', '--log-file', 'pylsp.log' },
    settings = {
        configurationSources = {'flake8'},
        plugins = {
            flake8 = {
                enabled = true
            }
        }
    }
}
EOF

" Compe setup
lua << EOF
require('compe').setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        ultisnips = true;
    };
}

local termcode_replace = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return termcode_replace "<C-n>"
    elseif check_back_space() then
        return termcode_replace "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return termcode_replace "<C-p>"
    else
        return termcode_replace "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

set completeopt=menuone,noselect

" Markdown preview
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" Automatically wrap lines for different filetypes
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.py setlocal textwidth=100

" Gdiffsplit opens vertically
set diffopt+=vertical

" Fern
nnoremap <silent> <C-b> :Fern . -toggle -drawer<CR>

" Disable the default keybindings for fern
let g:fern#disable_default_mappings = 1

" Hide python bytecode and git files
"let g:fern#default_hidden = 1
let g:fern#default_exclude = '^\%(\.git\|__pycache__/\|\.pyc\)$'

" Enable fern icons
let g:fern#renderer = "nerdfont"

" Special keybindings when fern is opened
function! FernInit() abort
    nmap <buffer><expr>
                \ <Plug>(fern-my-open-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open:select)",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )
    nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> m <Plug>(fern-action-new-path)
    nmap <buffer> zh <Plug>(fern-action-hidden-toggle)
    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> s <Plug>(fern-action-open:split)
    nmap <buffer> v <Plug>(fern-action-open:vsplit)
    nmap <buffer> h <Plug>(fern-action-leave)
    nmap <buffer> l <Plug>(fern-action-enter)
endfunction

augroup FernGroup
    autocmd!
    autocmd FileType fern call FernInit()
augroup END

" Remap windowswap keybindings
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> y :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> p :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> w :call WindowSwap#EasyWindowSwap()<CR>

" Swap light and dark colorschemes
function! SwapBG() abort
    if &bg == "dark"
        set bg=light
        highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
    else
        set bg=dark
        highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
    endif
endfunction
command! SwapBg call SwapBG()

" Set EasyAlign hotkeys
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Autoformatting
nnoremap <silent> <leader>q :Autoformat<CR>
vnoremap <silent> <leader>q :Autoformat<CR>

" Call Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Set indent marker options
let g:indentLine_char = '|'

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'CodeLLDB' ]

" Use xelatex instead of pdflatex
let g:livepreview_engine = 'xelatex'
let g:livepreview_previewer = 'evince'

" Tree-sitter
lua <<EOF
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true
    }
}
EOF

" tree-sitter config
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable

lua <<EOF
require('nvim-treesitter.configs').setup {
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
}
EOF

" WhichKey
set timeoutlen=200

" Set popup menus/windows to have pseudotransparency
set wildoptions=pum
set pumblend=20
set winblend=20

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

" Disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
