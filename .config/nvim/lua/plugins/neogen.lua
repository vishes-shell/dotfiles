return {
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        snippet_engine = "luasnip",
        languages = {
          python = {
            template = { annotation_convention = "google_docstrings" },
          },
        },
      }
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  }
}
