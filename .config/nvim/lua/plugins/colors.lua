return {
  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "latte",
      integrations = {
        blink_cmp = true,
        which_key = true,
        snacks = { enabled = true },
        flash = true,
      },
    },
  },
  { "folke/twilight.nvim" },
}
