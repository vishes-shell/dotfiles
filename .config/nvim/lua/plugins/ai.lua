return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        window = {
          position = "float",
          float = {
            width = "93%",
            height = "93%",
            border = "rounded",
          },
        },
        keymaps = {
          toggle = {
            normal = "<D-a>",
            terminal = "<D-a>",
          },
        },
      })
    end,
    keys = {
      { "<D-a>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
    },
  },
}
