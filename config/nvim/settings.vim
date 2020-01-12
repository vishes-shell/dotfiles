set t_Co=256
set background=dark
colorscheme one
let g:one_allow_italics = 1

if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" set vertical splitting in merge
set diffopt+=vertical

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set showcmd
set spell
let mapleader = ","

" set vertical splitting in merge
set diffopt+=vertical

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set number

" Sets how many lines of history VIM has to remember
set history=200

set ttimeout
set timeoutlen=500
set ttimeoutlen=20
set mouse-=a
set selectmode=mouse
set clipboard=

if has('nvim') &&  matchstr(execute('silent version'), 'NVIM v\zs[^\n-]*') >= '0.4.0'
    set inccommand=nosplit
    set wildoptions+=pum
    set signcolumn=yes:2
    set pumblend=10
endif

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set updatetime=400

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

set wildmenu

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left
set foldcolumn=1

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent

" Set the right margin.
set colorcolumn=88
" Automatically split words at the margin.
" au FileType markdown setlocal wrap
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown tw=80 fo+=t colorcolumn=80

" Disable folding because it's annoying.
set nofoldenable

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Allow project specific .vimrc files
set exrc
set secure

" Allow removing directories
let g:netrw_localrmdir="rm -r"
let g:netrw_list_hide='__pycache__'

let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au FileType python map <buffer> F :set foldmethod=indent<cr>
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
