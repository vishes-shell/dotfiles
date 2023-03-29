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
}
