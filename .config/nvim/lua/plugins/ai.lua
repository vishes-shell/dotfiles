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
    config = function()
      require("codecompanion").setup({
        adapters = {},
        strategies = {
          chat = { adapter = "anthropic" },
          inline = { adapter = "anthropic" },
        },
      })
    end,
  },
}
