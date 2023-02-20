return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "isort",
        "black",
        "jq",
        "ruff",
        "yamlfmt",
        "yamllint",
        "prettier",
      },
    },
  },
}
