return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ty = {
          settings = {
            ty = {
              inlayHints = {
                variableTypes = false,
                callArgumentNames = false,
              },
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
        "ty",
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
      { "<leader>yi", "<cmd>PythonCopyReferenceImport<cr>", desc = "Yank Python Import" },
      {
        "<leader>ar",
        function()
          local reference = vim.fn["python_copy_reference#_get_reference"]("pytest")
          local filename, ref = reference:match("^([^:]+)::(.+)$")
          local result
          if filename and ref then
            result = "`" .. ref .. "` @" .. filename
          else
            result = "@" .. reference
          end
          vim.fn.setreg("+", result)
          vim.notify("Copied: " .. result)
        end,
        desc = "Copy Claude Code reference",
      },
      {
        "<leader>af",
        function()
          local filename = vim.fn.expand("%:p:.")
          local result = "@" .. filename
          vim.fn.setreg("+", result)
          vim.notify("Copied: " .. result)
        end,
        desc = "Copy Claude Code file reference",
      },
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
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@module 'treesitter-modules'
    ---@type ts.mod.UserConfig
    opts = {
      incremental_selection = {
        enable = true,
        disable = {},
        keymaps = {
          init_selection = "<CR>", -- maps in normal mode to init the node/scope selection
          node_incremental = "<CR>", -- increment to the upper named parent
          scope_incremental = "<nop>", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "<BS>", -- decrement to the previous node
        },
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
  },
}
