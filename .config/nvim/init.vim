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
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'raimondi/delimitmate'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Debugging
Plug 'puremourning/vimspector'

" neovim IN THE BROWSER
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Autoformatting
Plug 'Chiel92/vim-autoformat'

" Select blocks of python text
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'

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

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'

" Initialize plugin system
call plug#end()

syntax enable
set termguicolors

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
"let g:airline_theme = 'gruvbox'
let ayucolor="dark"
colorscheme ayu

highlight illuminatedWord ctermbg=4 guibg=#444444

" Highlight colors
let g:Hexokinase_highlighters = ['virtual']

" Python and node paths
let g:python3_host_prog = expand('~/python39/bin/python3')
let g:coc_node_path = expand('~/.nvm/versions/node/v15.6.0/bin/node')
let g:node_host_prog = expand('~/.nvm/versions/node/v15.6.0/bin/neovim-node-host')

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

""Remap docstring lookup to ctrl-shift-/
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

" Remap original gf keybinding so it doesn't conflict
nnoremap <silent> gof gf
nmap gf <Plug>(coc-fix-current)

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

" Wrap at 100 for python
au BufRead,BufNewFile *.py setlocal textwidth=100


" Gdiffsplit opens vertically
set diffopt+=vertical

" Fern
" Open Fern with Ctrl+b
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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" How each level is indented and what to prepend.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

nnoremap <silent>  :Vista!!<CR>

" Python formatter
let g:formatterpath = ['/home/ubuntu/python39/bin/black']

nnoremap <silent> gbq gq
nnoremap gq :Autoformat<CR>

" Call Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Set indent marker options
let g:indentLine_char = '|'
