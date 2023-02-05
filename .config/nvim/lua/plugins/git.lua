return {
  {
    "dinhhuy258/git.nvim",
    config = function()
      require('git').setup({
        default_mappings = false,
      })
    end,
    keys = {
      {
        "<leader>gb",
        "<cmd>GitBlame<cr>",
        desc = "Git blame"
      }
    }

  }
}
