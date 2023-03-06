return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "isort",
        "black",
        "blackd-client",
        "jq",
        "ruff",
        "yamlfmt",
        "yamllint",
        "prettier",
        "bash-language-server",
      },
    },
  },
}
