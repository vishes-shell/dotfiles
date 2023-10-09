return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = {
          "ruff_fix",
          "isort",
          "blackd",
        },
      },
      formatters = {
        blackd = {
          command = "blackd-client",
          stdin = true,
          cwd = require("conform.util").root_file({
            "pyproject.toml",
          }),
        },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
}
