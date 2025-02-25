return {
  {
    "frankroeder/parrot.nvim",
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
    -- optionally include "rcarriga/nvim-notify" for beautiful notifications
    config = function()
      require("parrot").setup({
        providers = {
          anthropic = {
            api_key = os.getenv("PARROT_ANTHROPIC_API_KEY"),
            endpoint = os.getenv("PARROT_ANTHROPIC_API_URL"),
            topic = {
              model = "claude-3-5-haiku-latest",
            },
          },
          openai = {
            api_key = os.getenv("PARROT_OPENAI_API_KEY"),
            endpoint = os.getenv("PARROT_OPENAI_API_URL"),
            topic = {
              model = "gpt-4o-mini",
            },
          },
        },
      })
    end,
  },
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
              url = "https://api.proxyapi.ru/deepseek/chat/completions",
              env = {
                api_key = "CODE_COMPANION_DEEPSEEK_API_KEY",
              },
              schema = { model = { default = "deepseek-chat" } },
            })
          end,
        },
        strategies = {
          chat = { adapter = "openai" },
          inline = { adapter = "opanai" },
        },
      })
    end,
    keys = { { "<leader>cc", "<Cmd>CodeCompanionChat Toggle<CR>", desc = "Code Companion Chat" } },
  },
}
