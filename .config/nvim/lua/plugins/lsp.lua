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
        ["fish"] = {
          "fish_indent",
        },
        ["json"] = { "jq" },
        ["yaml"] = { "yamlfmt" },
        ["lua"] = { "stylua" },
        ["sql"] = { "sqlfmt" },
        ["markdown"] = { "markdownlint" },
      },
      formatters = {
        blackd = {
          command = "blackd-client",
          stdin = true,
        },
        sqlfmt = {
          command = "sqlfmt",
          args = { "-" },
          stdin = true,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
        lua = { "selene", "luacheck" },
        markdown = { "markdownlint" },
        python = { "ruff" },
        fish = { "fish" },
      },
      linters = {
        markdownlint = {
          cmd = "markdownlint-cli2",
        },
        fish = {
          cmd = "fish",
          stdin = false,
          args = { "--no-execute" },
        },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
  },
}
