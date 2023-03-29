return {
  {
    "dinhhuy258/git.nvim",
    config = function()
      require("git").setup({
        default_mappings = false,
      })
    end,
    keys = {
      {
        "<leader>gb",
        "<cmd>GitBlame<cr>",
        desc = "Git blame",
      },
    },
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
    },
  },
}
