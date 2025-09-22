return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
                autoSearchPaths = true,
                typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
                inlayHints = {
                  variableTypes = false,
                  callArgumentNames = false,
                  functionReturnTypes = false,
                  genericTypes = false,
                },
              },
              disableOrganizeImports = true,
              disableTaggedHints = true,
            },
          },
        },
        marksman = {},
        ts_ls = {},
        html = { init_options = { provideFormatter = false } },
      },
      format = {
        formatting_options = nil,
        timeout_ms = 3000,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "markdownlint",
        "jq",
        "ruff",
        "yamllint",
        "prettier",
        "bash-language-server",
        "stylua",
      },
    },
    -- version = "1.11.0",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
        "marksman",
        "ts_ls",
        "html",
      },
      handlers = {
        ["html"] = function()
          require("lspconfig").html.setup({
            filetypes = { "html", "htmldjango" },
          })
        end,
      },
    },
    -- version = "1.32.0",
  },
  {
    "ranelpadon/python-copy-reference.vim",
    ft = "python",
    keys = {
      { "<leader>yr", "<cmd>PythonCopyReferencePytest<cr>", desc = "Yank Python Reference" },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
  },
}
