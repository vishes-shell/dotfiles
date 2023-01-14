-----------------------------------------------------------
-- Null-ls configuration file
-----------------------------------------------------------
-- Plugin: null-ls
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.diagnostics.codespell, null_ls.builtins.diagnostics.alex,
    null_ls.builtins.formatting.isort, null_ls.builtins.formatting.black.with({
        extra_args = { "--fast", "--workers", "1" },
    }), null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.ruff, null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.lua_format.with({
        extra_args = {
            "--single-quote-to-double-quote", "--spaces-inside-table-braces",
            "--extra-sep-at-table-end", "--chop-down-kv-table",
        },
    }),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local callback = function()
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client) return client.name == "null-ls" end,
    })
end

null_ls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = callback,
            })
        end
    end,
})
