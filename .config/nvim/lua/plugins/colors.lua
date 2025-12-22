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
      auto_integrations = true,
      custom_highlights = function(colors)
        return {
          FlashLabel = { fg = colors.base, bg = colors.red, style = { "bold" } },
          FlashMatch = { fg = colors.text, bg = colors.surface1 },
          FlashCurrent = { fg = colors.base, bg = colors.peach, style = { "bold" } },
        }
      end,
    },
  },
  { "folke/twilight.nvim" },
  {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.special.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
}
