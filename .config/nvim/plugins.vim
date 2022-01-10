call plug#begin()

" Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asyncrun.vim'
" Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'rakr/vim-one'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
" Plug 'easymotion/vim-easymotion'
Plug 'janko/vim-test'
Plug 'junegunn/goyo.vim'
" Plug 'nicwest/vim-http'
Plug 'stsewd/fzf-checkout.vim'
" Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
" Plug 'chr4/nginx.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'SmiteshP/nvim-gps'
" Plug 'romgrk/nvim-treesitter-context'
" Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'catppuccin/nvim'
Plug 'lewis6991/spellsitter.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'famiu/feline.nvim'
Plug 'zhaozg/vim-diagram'
Plug 'ekalinin/Dockerfile.vim'
Plug 'numToStr/Comment.nvim'
Plug 'phaazon/hop.nvim'
Plug 'jmckiern/vim-venter'
Plug 'ibhagwan/fzf-lua'
Plug 'jose-elias-alvarez/null-ls.nvim'

call plug#end()

lua << EOF
  local lsp = require "lspconfig"
  -- local coq = require "coq"
  lsp.pyright.setup({})
  -- lsp.pyright.setup(coq.lsp_ensure_capabilities())

  lsp.sqls.setup({})
EOF

lua << EOF
require'lspconfig'.sqls.setup{
    cmd = { "sqls", ".config/sqls/config.yml" },
    picker = 'fzf',
}
EOF


lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "python", "toml", "yaml", "json" },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
    colors = {},
    termcolors = {}
  },
  indent = {
    enable = true
  },
  refactor = {
    highlight_definitions = { enable = true },
  },
}
EOF

lua << EOF
require'spellsitter'.setup {
    captures = {'comment'}
}
EOF

lua << EOF
require('feline').setup()
EOF

lua << EOF
require('gitsigns').setup()
EOF

lua << EOF
require('Comment').setup()
EOF

lua << EOF
require("hop").setup()
EOF

lua << EOF
local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup(
    {
		transparent_background = false,
		term_colors = false,
		styles = {
			comments = "italic",
			functions = "italic",
			keywords = "italic",
			strings = "NONE",
			variables = "NONE",
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic",
				},
				underlines = {
					errors = "underline",
					hints = "underline",
					warnings = "underline",
					information = "underline",
				},
			},
			lsp_trouble = true,
			lsp_saga = false,
			gitgutter = true,
			gitsigns = true,
			telescope = false,
			nvimtree = {
				enabled = false,
				show_root = false,
			},
			which_key = false,
			indent_blankline = {
				enabled = false,
				colored_indent_levels = false,
			},
			dashboard = false,
			neogit = false,
			vim_sneak = false,
			fern = false,
			barbar = false,
			bufferline = false,
			markdown = false,
			lightspeed = false,
			ts_rainbow = false,
			hop = true,
		},
	}
)
EOF

lua << EOF
require('fzf-lua').setup{
    winopts = {
        height = 0.85,
        width = 0.9,
        preview = {
            hidden = 'hidden',
        },
        on_create = function()
          vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>", 
          { silent = true, noremap = true })
          vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", "<Up>", 
          { silent = true, noremap = true })
        end,
    },
    keymap = {
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<F2>"]        = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"]        = "toggle-preview-wrap",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"]        = "toggle-preview-ccw",
          ["<F6>"]        = "toggle-preview-cw",
          ["<S-left>"]    = "preview-page-reset",
            ["?"] = "toggle-preview",
            ["ctrl-J"] = "preview-page-down",
            ["ctrl-K"]  = "preview-page-up",
        },
        fzf = {
          -- fzf '--bind=' options
          ["ctrl-z"]      = "abort",
          ["ctrl-u"]      = "unix-line-discard",
          ["ctrl-f"]      = "half-page-down",
          ["ctrl-b"]      = "half-page-up",
          ["ctrl-a"]      = "beginning-of-line",
          ["ctrl-e"]      = "end-of-line",
          ["alt-a"]       = "toggle-all",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"]          = "toggle-preview-wrap",
            ["?"] = "toggle-preview",
            ["ctrl-J"] = "preview-page-down",
            ["ctrl-K"]  = "preview-page-up",
        },
    }
}
EOF

lua << EOF
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.sqlformat,
        require("null-ls").builtins.formatting.black.with({
        args = {
            "$FILENAME",
            "--quiet",
            "--fast",
            }
        }),
        require("null-ls").builtins.diagnostics.gitlint,
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
        end
    end,
    debug = true
})
EOF

set completeopt=menu,menuone,noselect



" lua << EOF
" require'treesitter-context.config'.setup{
"     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
" }
" EOF

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf

let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_PREVIEW_COMMAND="bat --style=numbers,changes --color=always {}"
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_layout = { 'window': '-tabnew' }

command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>,
\                 '--hidden --ignore .git',
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

let g:fzf_tags_command = 'ctags -R --fields=+l --languages=python --python-kinds=-iv'



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

let g:ale_linters = {}
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\   'python': ['autoflake', 'isort', 'black']
\}


let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0

let g:ale_python_black_use_global = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_flake8_use_global = 1
let g:ale_python_isort_use_global = 1
let g:ale_python_autoflake_use_global = 1

let g:ale_python_autoflake_options = '--remove-all-unused-imports'

let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1

let g:ale_pattern_options_enabled = 0
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
" let g:UltiSnipsExpandTrigger='<tab>'
" let g:UltiSnipsExpandTrigger='S-<tab>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:EasyMotion_smartcase = 1
" let g:EasyMotion_use_smartsign_us = 1
" let g:EasyMotion_add_search_history = 0
" nmap s <Plug>(easymotion-sn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" " map <Leader>j <Plug>(easymotion-j)
" " map <Leader>k <Plug>(easymotion-k)

" hi link EasyMotionTarget SpecialChar
" hi link EasyMotionShade  LineNr
" hi link EasyMotionTarget2First String
" hi link EasyMotionTarget2Second String

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#strategy = 'asyncrun_background_term'
let test#python#runner = 'pytest'
let g:test#preserve_screen = 1
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
let test#python#pytest#options = '--reuse-db'

let g:goyo_width=90

" nnoremap <silent> <space><space> :<C-u>CocFzfList commands<CR>
" nnoremap <silent> <space>d :<C-u>CocFzfList diagnostics<CR>

let g:gutentags_enabled = 1
" let g:gutentags_generate_on_missing = 0
" let g:gutentags_generate_on_new = 0
let g:gutentags_file_list_command = { 'markers': { '.git': 'git ls-files', '.hg': 'hg files' } }
" let g:gutentags_ctags_executable_python = 'ctags --languages=python --python-kinds=-i'
let g:gutentags_define_advanced_commands = 1
nmap <leader>ct :GutentagsToggleEnabled<CR>
let g:gutentags_ctags_extra_args= [ '--languages=python',
\ '--fields=+l',
\ '--excmd=number',
\ '--python-kinds=-iv' ]


augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END

function! s:fzf_preview_settings() abort
  let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
endfunction

let $BAT_THEME = 'Monokai Extended Origin'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'Monokai Extended Origin'

let g:coq_settings = { 
\   'auto_start': v:true,
\   'display': {
\       'pum': {'fast_close': v:false}
\   },
\   'keymap': {
\       'recommended': v:true,
\       'jump_to_mark': '<c-n>',
\       'manual_complete': "<c-space>",
\       'bigger_preview': "<c-k>"
\   }
\}

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require('cmp')
  local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    },
    completion = {
        autocomplete = false
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
  local servers = { 'pyright' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    capabilities = capabilities
    }
  end
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
  local servers = { 'pyright' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

let g:lightline = { 'colorsheme': 'catppuccin' }

nnoremap <silent>s :HopPattern<CR>

hi link HopInitHighlight SpecialChar
