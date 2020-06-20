" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/syntastic'
Plug 'ronny/birds-of-paradise.vim'
Plug 'jacoborus/tender.vim'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'scrooloose/nerdcommenter'

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
set autoindent
set smartindent
inoremap <S-Tab> <C-d>
inoremap ^I <C-t>
vnoremap <S-Tab> <
vnoremap ^I >

" Automatically open a NERDTree on startup
autocmd vimenter * NERDTree

imap <C-_> NERDCommenterToggle
vmap <C-_> NERDCommenterToggle<CR>gv
nmap <C-_> <plug>NERDCommenterToggle   
