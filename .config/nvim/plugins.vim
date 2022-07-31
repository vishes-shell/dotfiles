call plug#begin()

Plug 'dense-analysis/ale'
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
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
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
Plug 'feline-nvim/feline.nvim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'numToStr/Comment.nvim'
Plug 'phaazon/hop.nvim'
Plug 'jmckiern/vim-venter'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'akinsho/git-conflict.nvim'
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'rcarriga/neotest'
Plug 'rcarriga/neotest-python'
Plug 'smjonas/inc-rename.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'lyokha/vim-xkbswitch'
Plug 'preservim/vim-lexical'
Plug 'rcarriga/nvim-notify'
Plug 'kevinhwang91/nvim-bqf'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'telyn/vim-mermaid'

call plug#end()


lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga()

vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, { silent = true,noremap = true })

local ca = require("lspsaga.codeaction")

vim.keymap.set("n", "<leader>ca", require("lspsaga.codeaction").code_action, { silent = true,noremap = true })
vim.keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    require("lspsaga.codeaction").range_code_action()
end, { silent = true,noremap =true })

vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })
-- scroll down hover doc or scroll in definition preview
vim.keymap.set("n", "<C-f>", function()
    require('lspsaga.action').smart_scroll_with_saga(1)
end, { silent = true })
-- scroll up hover doc
vim.keymap.set("n", "<C-b>", function()
    require('lspsaga.action').smart_scroll_with_saga(-1)
end, { silent = true })

vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true,noremap = true})

vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, { silent = true,noremap = true })

vim.keymap.set("n", "gd", require("lspsaga.definition").preview_definition, { silent = true,noremap = true })

vim.keymap.set("n", "<leader>cd", require("lspsaga.diagnostic").show_line_diagnostics, { silent = true,noremap = true })
vim.keymap.set("n", "[e", require("lspsaga.diagnostic").goto_prev, { silent = true, noremap =true })
vim.keymap.set("n", "]e", require("lspsaga.diagnostic").goto_next, { silent = true, noremap =true })

local term = require("lspsaga.floaterm")
vim.keymap.set("n", "<A-d>", function()
    term.open_float_terminal()
end, { silent = true,noremap = true })

vim.keymap.set("t", "<A-d>", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true))
    term.close_float_terminal()
end, { silent = true })

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
local api = vim.api
local fn = vim.fn
local bo = vim.bo

local feline = require("feline")
local vi_mode = require("feline.providers.vi_mode")
local git = require("feline.providers.git")
local navic = require("nvim-navic")

local ctp_feline = require('catppuccin.groups.integrations.feline')

feline.setup({
  components = ctp_feline,
  vi_mode_colors = vi_mode_colors,
  force_inactive = {
    filetypes = {
      "^NvimTree$",
      "^packer$",
      "^startify$",
      "^fugitive$",
      "^fugitiveblame$",
      "^qf$",
      "^help$",
      "^TelescopePrompt$",
    },
    buftypes = {
      "^terminal$",
      "^nofile$",
    },
  },
  custom_providers = {
    position_custom = function()
      local line, col = unpack(api.nvim_win_get_cursor(0))
      col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

      return string.format("Ln %d, Col %d", line, col)
    end,
    relative_file_path_parts = function()
      local filename = api.nvim_buf_get_name(0)
      if filename == "" then
        return " "
      end
      local fileparts = fn.fnamemodify(filename, ":~:.:h")
      if fileparts == "." then
        return " "
      end
      return " " .. fn.fnamemodify(fileparts, ":gs?/? > ?") .. " > "
    end,
    file_info_custom = function(component, opts)
      local readonly_str, modified_str, icon

      -- Avoid loading nvim-web-devicons if an icon is provided already
      if not component.icon then
        local icon_str, icon_color =
          require("nvim-web-devicons").get_icon_color(
            fn.expand("%:t"),
            nil, -- extension is already computed by nvim-web-devicons
            { default = true }
          )

        icon = { str = icon_str }

        if opts.colored_icon == nil or opts.colored_icon then
          icon.hl = { fg = icon_color }
        end
      end

      local filename = api.nvim_buf_get_name(0)
      local type = opts.type or "base-only"
      if filename == "" then
        filename = "[No Name]"
      elseif type == "short-path" then
        filename = fn.pathshorten(filename)
      elseif type == "base-only" then
        filename = fn.fnamemodify(filename, ":t")
      elseif type == "relative" then
        filename = fn.fnamemodify(filename, ":~:.")
      elseif type == "relative-short" then
        filename = fn.pathshorten(fn.fnamemodify(filename, ":~:."))
      elseif type ~= "full-path" then
        filename = fn.fnamemodify(filename, ":t")
      end

      if opts.show_readonly_icon and bo.readonly then
        readonly_str = opts.file_readonly_icon or "🔒"
      else
        readonly_str = ""
      end

      -- Add a space at the beginning of the provider if there is an icon
      if (icon and icon ~= "") or (component.icon and component.icon ~= "") then
        readonly_str = " " .. readonly_str
      end

      if opts.show_modified_icon and bo.modified then
        modified_str = opts.file_modified_icon or "●"

        if modified_str ~= "" then
          modified_str = " " .. modified_str
        end
      else
        modified_str = ""
      end

      -- escape any special statusline characters in the filename
      filename = filename:gsub("%%", "%%%%")
      return string.format("%s%s%s", readonly_str, filename, modified_str), icon
    end,
  },
})

local winbar_components = {
  active = {
    {
      {
        provider = "relative_file_path_parts",
      },
      {
        provider = "file_info_custom",
        opts = {
          type = "base-only",
          colored_icon = false,
          show_modified_icon = false,
        },
      },
      {
        enabled = function()
          return navic.is_available()
        end,
        provider = function()
          local location = navic.get_location()
          if location ~= "" then
            return " > " .. location
          end
          return ""
        end,
      },
    },
  },
  inactive = {
    {
      {
        provider = "file_info",
        left_sep = " ",
        opts = {
          type = "unique",
        },
      },
    },
  },
}

feline.winbar.setup({
  components = winbar_components,
  disable = {
    filetypes = {
      "^NvimTree$",
      "^lir$",
    },
  },
})
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
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    transparent_background = false,
    term_colors = false,
    compile = {
        enabled = false,
        path = vim.fn.stdpath "cache" .. "/catppuccin",
        suffix = "_compiled"
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        coc_nvim = false,
        lsp_trouble = false,
        cmp = true,
        lsp_saga = tru,
        gitgutter = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = false,
            show_root = false,
            transparent_panel = false,
        },
        neotree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
        },
        dap = {
            enabled = false,
            enable_ui = false,
        },
        which_key = false,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        dashboard = false,
        neogit = false,
        vim_sneak = false,
        fern = false,
        barbar = false,
        bufferline = true,
        markdown = true,
        lightspeed = false,
        ts_rainbow = true,
        hop = false,
        notify = true,
        telekasten = false,
        symbols_outline = false,
        mini = false,
    }
}
)

vim.g.catppuccin_flavour = "latte"
vim.cmd[[colorscheme catppuccin]]
EOF

" lua << EOF
" require("null-ls").setup({
"     sources = {
"         require("null-ls").builtins.formatting.isort,
"         require("null-ls").builtins.formatting.sqlformat,
"         require("null-ls").builtins.formatting.black.with({
"         args = {
"             "$FILENAME",
"             "--quiet",
"             "--fast",
"             }
"         }),
"         require("null-ls").builtins.diagnostics.gitlint,
"     },
"     on_attach = function(client)
"         if client.resolved_capabilities.document_formatting then
"             vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
"         end
"     end,
"     debug = true
" })
" EOF


lua << EOF
require("bufferline").setup{}
EOF


lua << EOF
require('git-conflict').setup({
  disable_diagnostics = true,
  highlights = { -- They must have background color, otherwise the default color will be used
    incoming = 'DiffText',
    current = 'DiffAdd',
  }
})
EOF


lua << EOF
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      args = {"--reuse-db"},
      runner = "pytest",
    }),
  },
})
EOF

lua << EOF
vim.keymap.set("n", "<leader>rn", ":IncRename ")
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
\ call fzf#vim#files(<q-args>, '--hidden --ignore .git', fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>,
\                 '--hidden --ignore .git',
\                 <bang>0 ? fzf#vim#with_preview('up:60%')
\                         : fzf#vim#with_preview('right:50%:hidden', '?'),
\                 <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --hidden --glob "!**/.git/**" --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, fzf#vim#with_preview(), <bang>0)
endif

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

let g:fzf_commits_log_options = "--color=always --format='%C(auto)%h%d %s %C(green)%cr (%C(cyan)%an)'"


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
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_project_root = ['.root']
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_ctags_tagfile = 'tags'
let g:gutentags_plus_nomap = 1


augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END

function! s:fzf_preview_settings() abort
  let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
endfunction

let $BAT_THEME = 'Coldark-Cold'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'Coldark-Cold'

lua <<EOF
  -- Setup nvim-cmp.
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  local cmp = require('cmp')
  local nvim_lsp = require('lspconfig')
  local luasnip = require("luasnip")

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  require("nvim-navic").attach(client, bufnr)

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
      expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    },
    completion = {
        autocomplete = true
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
  local servers = { 'pyright' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end

require('ufo').setup()
EOF

let g:lightline = { 'colorsheme': 'catppuccin' }

nnoremap <silent>s :HopPattern<CR>

hi link HopInitHighlight SpecialChar

let g:XkbSwitchEnabled = 1


augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#spelllang = ['en_us','en_ca', 'en_gb','ru_ru']


lua <<EOF
vim.notify = require("notify")
EOF

lua <<EOF
require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/my_snippets"})
EOF

" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
