return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-emoji" },
      {
        "uga-rosa/cmp-dictionary",
        lazy = false,
        config = function()
          require('cmp_dictionary').setup({
            async = true,
            dic = {
              ['markdown'] = {
                vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-components"),
                vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-labels")
              }
            },
            debug = false,
          })
        end,
      }
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(
        opts.sources,
        {
          { name = "emoji" },
          { name = "dictionary", keyword_length = 2, }
        }))
    end,
  },
}
