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
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'davidhalter/jedi-vim'
Plug 'osyo-manga/vim-over'

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
filetype plugin on

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab

" Ta
imap <S-Tab> <C-d>
imap ^I <C-t>
imap <C-Tab><C-t>
vmap <S-Tab> <gv
vmap ^I >gv
vmap <Tab> >gv
" Automatically open a NERDTree on startup
autocmd vimenter * if &filetype !=# 'gitcommit' && &filetype !=# 'gitrebase' | NERDTree | endif

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

set splitbelow
set splitright

highlight VertSplit ctermfg=Brown ctermbg=Black
let mapleader=","

" Strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Ctrl+BS to delete word backwards
imap <C-BS> <C-w>

highlight EndOfBuffer ctermfg=235

" Easymotion bindings
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Clear last search highlighting
nmap <M-/> :let @/=""<CR>
