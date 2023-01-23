-----------------------------------------------------------
-- Mason tool installer configuration file
-----------------------------------------------------------
-- Plugin: mason-tool-installer
-- url: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
require("mason-tool-installer").setup({
    ensure_installed = {
        "isort", "black", "vulture", "vulture", "jq", "ruff", "ruff-lsp",
        "yamlfmt", "yamllint",
    },
})
