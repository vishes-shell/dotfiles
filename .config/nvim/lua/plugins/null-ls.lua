local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

sqlfmt = h.make_builtin({
  method = FORMATTING,
  filetype = { 'sql' },
  generator_opt = {
    command = 'sqlfmt',
    args = {},
    to_stdin = true,
  },
  factory = h.formatter_factory
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
          sqlfmt,
        },
      }
    end,
  },
}
