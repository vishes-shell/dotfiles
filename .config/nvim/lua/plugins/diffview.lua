return {
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
}
