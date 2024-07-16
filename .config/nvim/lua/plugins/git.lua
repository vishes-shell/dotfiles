return {
  {
    "tpope/vim-fugitive",
    keys = {
      {
        "<leader>gb",
        "<cmd>Git blame<cr>",
        desc = "Git blame",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    config = true,
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "File git history" },
      {
        "<leader>gdr",
        function()
          vim.ui.input({ prompt = "Target branch" }, function(branch)
            if branch then
              vim.cmd({
                cmd = "DiffviewOpen",
                args = {
                  branch .. "...",
                  "--imply-local",
                },
              })
            end
          end)
        end,
        desc = "Review changes with target branch",
      },
    },
  },
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
}
