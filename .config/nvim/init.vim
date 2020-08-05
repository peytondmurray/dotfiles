" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'osyo-manga/vim-over'
Plug 'kshenoy/vim-signature'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" Themes
Plug 'ronny/birds-of-paradise.vim'
Plug 'jacoborus/tender.vim'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'scrooloose/nerdcommenter'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Linting
Plug 'w0rp/ale'
"Plug 'scrooloose/syntastic'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

" Easy motion
Plug 'easymotion/vim-easymotion'

" Initialize plugin system
call plug#end()

colorscheme tender
let g:airline_theme = 'tender'

" Show indent guidelines by default
let g:indent_guides_enable_on_vim_startup = 1
let g:python3_host_prog = '~/python38/bin/python3'

" Instant markdown
filetype plugin indent on

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

imap <C-_> <Esc><plug>NERDCommenterTogglei
vmap <C-_> <plug>NERDCommenterTogglegv
nmap <C-_> <plug>NERDCommenterToggle

" Show line numbers
set number

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
let mapleader=","

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Ctrl+BS to delete word backwards
imap <C-BS> <C-w>
imap  <C-w>

" Make tildes at end of file invisible
highlight EndOfBuffer ctermfg=235

" Easymotion bindings
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Clear last search highlighting
nmap <M-/> :let @/=""<CR>

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
let g:ale_linters = {
    \'python': ['flake8', 'mypy']
\}

let g:ale_python_flake8_options = '--max-line-length=100'
nmap <Leader>j :ALENext<CR>
nmap <Leader>k :ALEPrevious<CR>

" Show marks, but inherit color from gitgutter
let g:SignatureMarkTextHLDynamic = 1

" Use numpydoc docstrings
let g:pydocstring_formatter = 'numpy'
nmap <C-D> <Plug>(pydocstring)
