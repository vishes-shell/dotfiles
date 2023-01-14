-----------------------------------------------------------
-- Mason LSP configuration file
-----------------------------------------------------------
-- Plugin: mason-lspconfig
-- url: https://github.com/williamboman/mason-lspconfig.nvim
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "marksman", "sumneko_lua" },
})
