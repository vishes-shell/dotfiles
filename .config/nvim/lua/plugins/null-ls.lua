local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

local sqlfmt = h.make_builtin({
  name = "sqlfmt",
  meta = {
    url = "https://github.com/tconbeer/sqlfmt",
    description = "sqlfmt formats your dbt SQL files so you don't have to",
  },
  method = FORMATTING,
  filetypes = { "sql", "pgsql" },
  generator_opts = {
    command = "sqlfmt",
    to_stdin = true,
    args = { "-" },
  },
  factory = h.formatter_factory,
})

local blackd = h.make_builtin({
  name = "blackd",
  method = FORMATTING,
  filetypes = { "python" },
  generator = h.formatter_factory({
    command = "blackd-client",
    to_stdin = true,
  }),
})

return {
  {
    "nvimtools/none-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- diagnostics
          -- nls.builtins.diagnostics.ruff,
          nls.builtins.diagnostics.yamllint,
          nls.builtins.diagnostics.markdownlint.with({
            filetypes = { "markdown" },
            command = "markdownlint-cli2",
          }),
          -- formatting
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          -- nls.builtins.formatting.isort,
          -- blackd,
          nls.builtins.formatting.jq,
          nls.builtins.formatting.yamlfmt,
          nls.builtins.formatting.stylua,
          sqlfmt,
          nls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
            },
          }),
        },
        on_attach = function(_, bufnr)
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
        end,
      }
    end,
  },
}
