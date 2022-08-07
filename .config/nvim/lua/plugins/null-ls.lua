-----------------------------------------------------------
-- Null-ls configuration file
-----------------------------------------------------------

-- Plugin: null-ls
-- url: https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ls = require("null-ls")

sourses = {
  null_ls.builtins.diagnostics.codespell,

  null_ls.builtins.diagnostics.alex,
  null_ls.builtins.formatting.remark,

  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.black,

  null_ls.builtins.diagnostics.vulture,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.pylint,
  null_ls.builtins.diagnostics.semgrep,

  null_ls.builtins.diagnostics.yamllint,

  null_ls.builtins.formatting.jq,
}

null_ls.setup({ sources = sources })
