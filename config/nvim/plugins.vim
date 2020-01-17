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
    call dein#add('luochen1990/rainbow')

    call dein#add('junegunn/fzf.vim')

    call dein#add('ervandew/supertab')
    call dein#add('skywind3000/asyncrun.vim', {'on_cmd': ['AsyncRun', 'AsyncStop']})
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-vinegar')

    call dein#add('SirVer/ultisnips')
    call dein#add('jiangmiao/auto-pairs')

    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('rakr/vim-one')

    call dein#add('cohama/agit.vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('idanarye/vim-merginal')

    call dein#add('nicwest/vim-http')

    call dein#add('idanarye/vim-merginal')

    call dein#add('prabirshrestha/async.vim')
    call dein#add('prabirshrestha/asyncomplete.vim')
    call dein#add('prabirshrestha/asyncomplete-lsp.vim')
    call dein#add('prabirshrestha/vim-lsp')
    call dein#add('mattn/vim-lsp-settings')

    call dein#add('machakann/vim-highlightedyank')

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

let $FZF_DEFAULT_COMMAND = 'ag -g ""'



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
let g:ale_set_balloons_legacy_echo = 1
let g:ale_c_parse_compile_commands = 1

" Options for different linters.
let g:ale_python_mypy_ignore_invalid_syntax = 1
let g:ale_python_mypy_options = '--incremental'
let g:ale_typescript_tslint_ignore_empty_files = 1
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

let g:ale_python_black_use_global = 1
let g:ale_python_mypy_use_global = 1

let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

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
