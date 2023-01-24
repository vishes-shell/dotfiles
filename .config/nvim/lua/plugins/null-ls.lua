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
        },
      }
    end,
  },
}
