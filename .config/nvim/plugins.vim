" First, setup global variables
let s:config_dir = substitute(expand('<sfile>:p:h'), '\', '/', 'g')
let s:bundle_dir = s:config_dir . "/.cache/dein"
let s:dein_dir = s:bundle_dir . "/repos/github.com/Shougo/dein.vim"
let s:do_update = 0


" If dein isn't already there, install it
if !isdirectory(s:dein_dir)
    call mkdir(fnamemodify(s:dein_dir, "h"), "p")
    execute '!git clone --depth 1 --branch master "https://github.com/Shougo/dein.vim" "' . s:dein_dir . '"'
    let s:do_update = 1
endif
execute("set runtimepath+=" . s:dein_dir)

if dein#load_state(s:bundle_dir)
    call dein#begin(s:bundle_dir)

    call dein#add('https://github.com/Shougo/dein.vim',   {'hook_done_update': 'execute "UpdateRemotePlugins"'})

    " syntax and formating
    call dein#add('dense-analysis/ale')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('vim-python/python-syntax')
    call dein#add('Vimjas/vim-python-pep8-indent')
    call dein#add('luochen1990/rainbow')

    call dein#add('junegunn/fzf.vim')

    call dein#add('skywind3000/asyncrun.vim', {'on_cmd': ['AsyncRun', 'AsyncStop']})
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-vinegar')

    call dein#add('SirVer/ultisnips')

    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('rakr/vim-one')

    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    call dein#add('nicwest/vim-http')

    call dein#add('prabirshrestha/async.vim')
    
    call dein#add('neoclide/coc.nvim', {'merged':0, 'build': 'yarn install --frozen-lockfile'})
    call dein#add('machakann/vim-highlightedyank')

    call dein#add('easymotion/vim-easymotion')
    call dein#add('vimwiki/vimwiki')

    call dein#add('janko/vim-test')

    call dein#add('ludovicchabant/vim-gutentags')

    call dein#add('junegunn/goyo.vim')

    call dein#add('liuchengxu/vista.vim')

    call dein#add('nicwest/vim-http')

    call dein#end()
    call dein#save_state()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf

let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_PREVIEW_COMMAND="bat --style=numbers,changes --color=always {}"
let g:fzf_layout = { 'window': '-tabnew' }

command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>,
\                 <bang>0 ? fzf#vim#with_preview('up:60%')
\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
\                 <bang>0)


let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }

let g:fzf_commits_log_options = "--branches=* --color=always --format='%C(auto)%h%d %s %C(green)%cr (%C(cyan)%an)'"

let g:fzf_tags_command = 'ctags -R --output-format=json --fields=+l --languages=python --python-kinds=-iv'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='one'
let g:airline_highlighting_cache = 1
let g:airline_detect_spelllang=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#coc#enabled = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable ALE warnings about trailing whitespace.
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'
highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#C30500 guibg=#F5F5F5
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237 guibg=#F5F5F5
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_maximum_file_size = 1024 * 1024
let g:ale_completion_enabled = 0
let g:ale_set_balloons_legacy_echo = 1
let g:ale_c_parse_compile_commands = 1

" Options for different linters.
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--incremental'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Use newer clang versions where available.
if executable('clang-6.0')
    let g:ale_c_clang_executable = 'clang-6.0'
    let g:ale_cpp_clang_executable = 'clang-6.0'
endif

if executable('clangd-6.0')
    let g:ale_c_clangd_executable = 'clangd-6.0'
    let g:ale_cpp_clangd_executable = 'clangd-6.0'
endif

let g:ale_fixers = {
\   'python': ['isort', 'black']
\}
let g:ale_linters = {
\   'python': ['mypy', 'flake8', 'pylint']
\}

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0

let g:ale_python_black_use_global = 0
let g:ale_python_mypy_use_global = 0
let g:ale_python_pylint_use_global = 0
let g:ale_python_flake8_use_global = 0

let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AsyncRun
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:quickfix_height = 8
let g:asyncrun_status = ''  " asyncrun is lazy loaded
" automatically open quickfix at height value g:quickfix_height
let g:asyncrun_open = g:quickfix_height


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsExpandTrigger='S-<tab>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_add_search_history = 0
nmap s <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)

hi link EasyMotionTarget SpecialChar
hi link EasyMotionShade  LineNr
hi link EasyMotionTarget2First String
hi link EasyMotionTarget2Second String

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = 'neovim'
let test#strategy = {
    \ 'nearest': 'neovim',
    \ 'file': 'neovim',
    \ 'suite': 'asyncrun',
\}
let test#python#runner = 'pytest'
let g:test#preserve_screen = 1
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
let test#python#pytest#options = '--reuse-db'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


let g:goyo_width=90

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
