return {
  {
    "nvim-cmp",
    enabled = false,
    lazy = true,
    event = "InsertEnter",
    dependencies = { "ray-x/cmp-treesitter", "hrsh7th/cmp-buffer" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        -- {
        --   name = "luasnip",
        --   group_index = 1,
        --   option = { use_show_condition = true },
        --   entry_filter = function()
        --     local context = require("cmp.config.context")
        --     return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
        --   end,
        -- },
        { name = "path" },
        { name = "treesitter" },
        { name = "buffer" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
          settings = {
            python = {
              analysis = {
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
                autoSearchPaths = true,
                typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
              },
              disableOrganizeImports = true,
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
  -- {
  --   "L3MON4D3/LuaSnip",
  --   lazy = true,
  --   config = function()
  --     local ls = require("luasnip")
  --     local types = require("luasnip.util.types")
  --
  --     vim.api.nvim_set_hl(0, "LuasnipChoiceNodePassive", { italic = true })
  --     vim.api.nvim_set_hl(0, "LuasnipChoiceNodeActive", { bold = true })
  --
  --     ls.config.set_config({
  --       history = true,
  --       region_check_events = "CursorMoved,CursorHold,InsertEnter",
  --       delete_check_events = "InsertLeave",
  --       ext_opts = {
  --         [types.choiceNode] = {
  --           active = {
  --             virt_text = { { "", "Operator" } }, -- 
  --             hl_mode = "combine",
  --           },
  --         },
  --         [types.insertNode] = {
  --           active = {
  --             virt_text = { { "", "Type" } }, -- 
  --             hl_mode = "combine",
  --           },
  --         },
  --       },
  --       enable_autosnippets = true,
  --     })
  --
  --     local function next_choice()
  --       if ls.choice_active() then
  --         ls.change_choice(1)
  --       end
  --     end
  --     local opts = { silent = true }
  --     vim.keymap.set("i", "<C-e>", next_choice, opts)
  --     vim.keymap.set("s", "<C-e>", next_choice, opts)
  --   end,
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     config = function()
  --       require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
  --     end,
  --   },
  -- },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "markdownlint",
        "isort",
        "black",
        "blackd-client",
        "jq",
        "ruff",
        "yamllint",
        "prettier",
        "bash-language-server",
        "stylua",
        "selene",
        "luacheck",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
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
  },
  {
    "ranelpadon/python-copy-reference.vim",
    ft = "python",
    keys = {
      { "<leader>yr", "<cmd>PythonCopyReferencePytest<cr>", desc = "Yank Python Reference" },
    },
  },
}
