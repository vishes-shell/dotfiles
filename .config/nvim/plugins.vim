call plug#begin()

Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'
Plug 'janko/vim-test'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/goyo.vim'
Plug 'nicwest/vim-http'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


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
\                 '--hidden',
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
let g:ale_code_actions_enabled = 0
let g:ale_set_balloons_legacy_echo = 0
let g:ale_c_parse_compile_commands = 1


" Options for different linters.
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 0

let g:ale_fixers = {
\   'python': ['isort', 'black']
\}


let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0

let g:ale_python_black_use_global = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_isort_use_global = 1

let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1

let g:ale_pattern_options_enabled = 1
let g:ale_pattern_options = {
\   'site-packages/.*$': {
\       'ale_enabled': 0,
\       '&modifiable': 0,
\   },
\   '\v\.min\.(js|css)$': {
\       'ale_linters': [],
\       'ale_fixers': [],
\   },
\   'node_modules': {
\       'ale_fixers': [],
\   },
\}

let g:ale_disable_lsp = 1


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

let g:goyo_width=90


