return {
  {
    "nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-emoji", "lukas-reineke/cmp-under-comparator", "ray-x/cmp-treesitter" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emoji" },
        { name = "treesitter" },
      }))
      opts.sorting.comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      }
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
        tsserver = {},
      },
      format = {
        formatting_options = nil,
        timeout_ms = 3000,
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      vim.api.nvim_set_hl(0, "LuasnipChoiceNodePassive", { italic = true })
      vim.api.nvim_set_hl(0, "LuasnipChoiceNodeActive", { bold = true })

      ls.config.set_config({
        history = true,
        region_check_events = "CursorMoved,CursorHold,InsertEnter",
        delete_check_events = "InsertLeave",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "", "Operator" } }, -- 
              hl_mode = "combine",
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "", "Type" } }, -- 
              hl_mode = "combine",
            },
          },
        },
        enable_autosnippets = true,
      })

      local function next_choice()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end
      local opts = { silent = true }
      vim.keymap.set("i", "<C-e>", next_choice, opts)
      vim.keymap.set("s", "<C-e>", next_choice, opts)
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
      end,
    },
  },
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
    end,
  },
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
        "yamlfmt",
        "yamllint",
        "prettier",
        "bash-language-server",
        "stylua",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "marksman",
        "tsserver",
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
