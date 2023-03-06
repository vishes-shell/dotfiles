return {
  {
    "danymat/neogen",
    keys = {
      {
        '<leader>nf',
        function()
          require('neogen').generate {}
        end,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      snippet_engine = 'luasnip',
      languages = {
        python = {
          template = {
            annotation_convention = 'google_docstrings',
          },
        },
      },
    },
  }
}
