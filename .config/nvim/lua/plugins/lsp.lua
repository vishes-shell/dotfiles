return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["python"] = {
          "ruff_fix",
          "ruff_format",
          -- "isort",
          -- "blackd",
        },
        ["fish"] = {
          "fish_indent",
        },
        ["json"] = { "jq" },
        ["lua"] = { "stylua" },
        ["sql"] = { "sqlfmt" },
        ["markdown"] = { "markdownlint" },
        ["javascript"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "prettierd", "prettier" } },
        ["javascriptreact"] = { { "prettierd", "prettier" } },
        ["typescriptreact"] = { { "prettierd", "prettier" } },
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
        lua = { "luacheck" },
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
