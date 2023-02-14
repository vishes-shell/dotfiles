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

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- diagnostics
          nls.builtins.diagnostics.ruff,
          nls.builtins.diagnostics.yamllint,
          -- formatting
          nls.builtins.formatting.isort,
          nls.builtins.formatting.black.with({ extra_args = { "--fast", "--workers", "1" } }),
          nls.builtins.formatting.jq,
          nls.builtins.formatting.yamlfmt,
          nls.builtins.formatting.stylua,
          sqlfmt,
        },
      }
    end,
  },
}
