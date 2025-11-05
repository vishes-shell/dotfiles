return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
      require("codecompanion").setup({
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              url = "https://api.proxyapi.ru/anthropic/v1/messages",
              env = {
                api_key = "CODE_COMPANION_ANTHROPIC_API_KEY",
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              url = "https://api.proxyapi.ru/openai/v1/chat/completions",
              env = {
                api_key = "CODE_COMPANION_OPENAI_API_KEY",
              },
              schema = { model = { default = "gpt-4o-mini" } },
            })
          end,
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              url = "https://api.deepseek.com/v1/chat/completions",
              env = {
                api_key = "CODE_COMPANION_DEEPSEEK_API_KEY",
              },
              schema = { model = { default = "deepseek-chat" } },
            })
          end,
        },
        strategies = {
          chat = { adapter = "deepseek" },
          inline = { adapter = "deepseek" },
        },
      })
    end,
    keys = { { "<leader>cc", "<Cmd>CodeCompanionChat Toggle<CR>", desc = "Code Companion Chat" } },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
  },
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        mux = {
          backend = "zellij",
          enabled = true,
        },
      },
      nes = { enabled = false },
      copilot = { status = { enabled = false } },
    },
  },
}
