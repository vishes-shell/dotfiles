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
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true, -- Show mcp tool results in chat
              make_vars = true, -- Convert resources to #variables
              make_slash_commands = true, -- Add prompts as /slash commands
            },
          },
        },
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
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
}
