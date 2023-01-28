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
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    snippet_engine = { 'luasnip' }

  }
}
