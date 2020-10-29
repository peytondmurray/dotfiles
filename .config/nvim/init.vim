" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'ryanoasis/vim-devicons'
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
Plug 'raimondi/delimitmate'

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
Plug 'morhetz/gruvbox'
Plug 'ronny/birds-of-paradise.vim'
Plug 'jacoborus/tender.vim'

" Git Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

syntax enable
set termguicolors

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:airline_theme = 'gruvbox'
colorscheme gruvbox

" Highlight colors
let g:Hexokinase_highlighters = ['virtual']

" Show indent guidelines by default
let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=bg
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030

" Python and node paths
let g:python3_host_prog = expand('~/python38/bin/python3')
let g:coc_node_path = expand('~/.nvm/versions/node/v14.8.0/bin/node')
let g:node_host_prog = expand('~/.nvm/versions/node/v14.8.0/bin/neovim-node-host')

" Instant markdown
filetype plugin indent on

" Diagnostic messaging
set signcolumn=yes

" Case sensitive searching only when caps used
set ignorecase
set smartcase

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

" Control+/ to toggle comment status; visual mode uses gbv instead of gv,
" defined below to avoid conflict with "go to definition in vertical split"
" command
nnoremap gbv gv

imap <C-_> <Esc><plug>NERDCommenterTogglei
vmap <C-_> <plug>NERDCommenterTogglegbv
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
highlight VertSplit ctermfg=Brown ctermbg=Black

" Make the currently selected word a different color
highlight illuminatedWord ctermfg=0 ctermbg=6

" Make tildes at end of file invisible
highlight EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

let mapleader=","

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

" Make ; start fzf :Lines
nmap ; :Lines<CR>
nmap  :Files<CR>

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

" Remap original gv keybinding to gbv so it doesn't conflict
nnoremap <silent> gbv gv
nmap <silent> ge <Plug>(coc-definition)
nmap <silent> gs :split<CR><Plug>(coc-definition)
nmap <silent> gv :vsplit<CR><Plug>(coc-definition)
nmap gj <Plug>(coc-diagnostic-next)
nmap gk <Plug>(coc-diagnostic-prev)

" Use <BS> to show siimple hover type documentation in preview window
nnoremap <silent> <M-BS> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Map rn to rename a symbol
nmap rn <Plug>(coc-rename)

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

" Automatically wrap at 80 characters for .md
au BufRead,BufNewFile *.md setlocal textwidth=80

" Gdiffsplit opens vertically
set diffopt+=vertical

" Fern
" Open Fern with Ctrl+b
nnoremap <C-b> :Fern . -toggle -drawer<CR>

" Disable the default keybindings for fern
let g:fern#disable_default_mappings = 1

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
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)j
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
