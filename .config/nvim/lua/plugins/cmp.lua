return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-emoji",
      { "hrsh7th/cmp-nvim-lsp", },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      {
        "uga-rosa/cmp-dictionary",
        lazy = true,
        config = function()
          require('cmp_dictionary').setup({
            async = true,
            dic = {
              ['markdown'] = {
                vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-component"),
                vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-label"),
                vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-assignee")
              }
            },
            debug = false,
          })
        end,
      },
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "emoji" },
          { name = "dictionary", keyword_length = 2, }
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end
  },
}
