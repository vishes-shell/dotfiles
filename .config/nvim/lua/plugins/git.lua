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
      { "<leader>gdx", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
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
}
