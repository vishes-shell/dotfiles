return {
  "folke/twilight.nvim",
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      }
    }
  },
  -- {
  --   "shortcuts/no-neck-pain.nvim",
  --   config = function()
  --     require('no-neck-pain').setup({
  --       debug = false,
  --       width = 120,
  --     })
  --   end,
  --   keys = { { "<leader>wn", "<cmd>NoNeckPain<cr>", desc = "Stop Neck pain" } },
  -- }
}
