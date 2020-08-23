" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-over'
Plug 'kshenoy/vim-signature'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'rrethy/vim-illuminate'
Plug 'guns/xterm-color-table.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'scrooloose/nerdcommenter'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" Themes
Plug 'ronny/birds-of-paradise.vim'
Plug 'jacoborus/tender.vim'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

colorscheme tender
let g:airline_theme = 'tender'

" Show indent guidelines by default
let g:indent_guides_enable_on_vim_startup = 1

" Python and node paths
let g:python3_host_prog = expand('~/python38/bin/python3')
let g:coc_node_path = expand('~/.nvm/versions/node/v14.8.0/bin/node')
let g:node_host_prog = expand('~/.nvm/versions/node/v14.8.0/bin/neovim-node-host')

" Instant markdown
filetype plugin indent on

" Better display for messages
set cmdheight=2

" Diagnostic messaging
set updatetime=300

set signcolumn=yes

" Case sensitive searching only when caps used
set smartcase

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab

" Automatically open a NERDTree on startup
autocmd vimenter * if &filetype !=# 'gitcommit' && &filetype !=# 'gitrebase' | NERDTree | endif

" Ignore python bytecode
let NERDTreeIgnore = ['\.pyc$', '__pycache__$']

nnoremap <C-b> :NERDTreeToggle<CR>
nmap <C-n> :TagbarToggle<CR>

" Control+/ to toggle comment status
imap <C-_> <Esc><plug>NERDCommenterTogglei
vmap <C-_> <plug>NERDCommenterTogglegv
nmap <C-_> <plug>NERDCommenterToggle

" Show line numbers
set number

" Highlight current cursor line
set cursorline

" Automatically update when the current file changes on disk
set autoread

 "Remap docstring lookup to ctrl-shift-/
nnoremap <BS> K

" Shift+HJKL to move a lot in normal mode
nnoremap J 30j
nnoremap K 30k

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
highlight VertSplit ctermfg=Brown ctermbg=Black

" Make the currently selected word a different color
highlight illuminatedWord ctermfg=0 ctermbg=6

let mapleader=","

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Ctrl+BS to delete word backwards
imap <C-BS> <C-w>
imap  <C-w>

" Make tildes at end of file invisible
highlight EndOfBuffer ctermfg=235

" Clear last search highlighting
nmap <silent> <M-/> :let @/=""<CR>

" Make ; start fzf :Lines
nmap ; :Lines<CR>

" Tab/Shift+Tab to indent/dedent
imap <S-Tab> <C-d>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Make s act like d, except it won't save anything to the register
nnoremap s "_d

" Alt+JK to move line down/up by one row
nmap <M-j> :m+1<CR>
nmap <M-k> :m-2<CR>

set rtp+=/home/pdmurray/.fzf/bin/fzf

" ALE linting options
"let g:ale_linters = {
    "\'python': ['flake8', 'mypy']
"\}

"let g:ale_python_flake8_options = '--max-line-length=100'
"nmap <Leader>j :ALENext<CR>
"nmap <Leader>k :ALEPrevious<CR>

" Show marks, but inherit color from gitgutter
let g:SignatureMarkTextHLDynamic = 1

" Use numpydoc docstrings
let g:pydocstring_formatter = 'numpy'
nmap <C-D> <Plug>(pydocstring)

let NERDTreeMinimalUI = 1

" COC Config
" Map <tab> to trigger completion and to move to next item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <silent> ge <Plug>(coc-definition)
nnoremap <silent> gs :split<CR><Plug>(coc-definition)
nnoremap <silent> gv :vsplit<CR><Plug>(coc-definition)
nmap gj <Plug>(coc-diagnostic-next)
nmap gk <Plug>(coc-diagnostic-prev)

" Markdown preview
let g:mkdp_auto_start = 1
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
