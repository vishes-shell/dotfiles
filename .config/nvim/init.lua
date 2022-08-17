require('packer_init')

require('core/globals')
require('core/options')
require('core/autocmds')
require('core/keymaps')
require('core/abbrev')

require('plugins/indent-blankline')
require('plugins/move')
require('plugins/null-ls')
require('plugins/treesitter')
require('plugins/mason-lspconfig')
require('plugins/mason-tool-installer')
require('plugins/catppuccin')
require('plugins/telescope')
require('plugins/lsp_saga')
require('plugins/lexical')
---@diagnostic disable-next-line: different-requires
require('plugins/luasnip')
require('plugins/cmp')
require('plugins/gutentags')
require('plugins/test')
require('plugins/neorg')
require('plugins/markdown-preview')
