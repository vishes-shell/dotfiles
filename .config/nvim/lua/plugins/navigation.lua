return {
  {
    "cbochs/portal.nvim",
    -- Optional dependencies
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon",
    },
    keys = {
      {
        "<leader>o",
        "<cmd>Portal jumplist backward<cr>",
        desc = "jump backward",
      },
      {
        "<leader>i",
        "<cmd>Portal jumplist forward<cr>",
        desc = "jump forward",
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    config = function()
      local spider = require("spider")
      vim.keymap.set({ "n", "o", "x" }, "w", function()
        spider.motion("w")
      end, { desc = "Spider-w" })

      vim.keymap.set({ "n", "o", "x" }, "e", function()
        spider.motion("e")
      end, { desc = "Spider-e" })

      vim.keymap.set({ "n", "o", "x" }, "b", function()
        spider.motion("b")
      end, { desc = "Spider-b" })

      vim.keymap.set({ "n", "o", "x" }, "ge", function()
        spider.motion("ge")
      end, { desc = "Spider-ge" })
    end,
  },
}
