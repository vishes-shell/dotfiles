return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = false,
        kitty = { enabled = true, font = "+2" },
      },
    },
    keys = { { "<leader>wz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}
