return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
      "onsails/lspkind.nvim",

      --   {
      --     lazy = true,
      --     config = function()
      --       require("cmp_dictionary").setup({
      --         async = true,
      --         dic = {
      --           ["markdown"] = {
      --             vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-component"),
      --             vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-label"),
      --             vim.fn.expand("~/.config/nvim/lua/dictionaries/jira-assignee"),
      --           },
      --         },
      --         debug = false,
      --       })
      --     end,
      --   },
      -- },
      opts = function()
        local cmp = require("cmp")
        local sources = {
          {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
          },
          {
            { name = "treesitter" },
            { name = "buffer" },
            { name = "path" },
            { name = "spell" },
            { name = "dictionary" },
            { name = "emoji" },
          },
        }
        local winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"

        local luasnip = require("luasnip")
        require("luasnip.loaders.from_vscode").load()

        -- local mapping for nvim-cmp.
        local function has_words_before()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))

          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local mapping = {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.mapping.complete({})
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm(),
        }

        cmp.setup.filetype("gitcommit", {
          sources = cmp.config.sources({
            { name = "cmp_git" },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "nvim_lsp_document_symbol" },
            { name = "buffer" },
            { name = "dictionary" },
            { name = "spell" },
            { name = "path" },
            { name = "emoji", insert = false },
          }),
        })

        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lsp_document_symbol" },
            { name = "dictionary" },
            { name = "buffer" },
            { name = "emoji", insert = false },
          },
        })

        local cmp_symbols = {
          Text = " ",
          Method = " ",
          Function = "",
          Constructor = " ",
          Field = " ",
          Variable = " ",
          Class = " ",
          Interface = " ",
          Module = " ",
          Property = " ",
          Unit = "塞",
          Value = " ",
          Enum = " ",
          Keyword = " ",
          Snippet = " ",
          Color = " ",
          File = " ",
          Reference = " ",
          Folder = " ",
          EnumMember = " ",
          Constant = " ",
          Struct = " ",
          Event = "",
          Operator = " ",
          TypeParameter = " ",
        }

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "cmdline" },
            { name = "path", options = { trailing_slash = true, label_trailing_slash = true } },
            { name = "dictionary" },
            { name = "buffer" },
            { name = "emoji" },
          }),
        })

        return {
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered({ winhighlight = winhighlight }),
            documentation = cmp.config.window.bordered({ winhighlight = winhighlight }),
            preview = cmp.config.window.bordered({ winhighlight = winhighlight }),
          },
          formatting = {
            format = require("lspkind").cmp_format({
              mode = "symbol",
              ellipsis_char = "…",
              menu = {
                nvim_lsp = "lsp",
                nvim_lua = "lua",
                luasnip = "snip",
                buffer = "buf",
                path = "path",
                calc = "calc",
                vsnip = "snip",
                nvim_lsp_signature_help = "sign",
                treesitter = "ts",
                spell = "spel",
                dictionary = "dict",
                zsh = "zsh",
                emoji = "emoji",
                ["vim-dadbod-completion"] = "db",
              },
              symbol_map = cmp_symbols,
            }),
          },
          mapping = cmp.mapping.preset.insert(mapping),
          sources = cmp.config.sources(sources[1], sources[2]),
        }

        -- return {
        --   completion = {
        --     completeopt = "menu,menuone,noinsert",
        --   },
        --   snippet = {
        --     expand = function(args)
        --       require("luasnip").lsp_expand(args.body)
        --     end,
        --   },
        --   mapping = cmp.mapping.preset.insert({
        --     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        --     ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --     ["<C-Space>"] = cmp.mapping.complete(),
        --     ["<C-e>"] = cmp.mapping.abort(),
        --     ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        --   }),
        --   sources = cmp.config.sources({
        --     { name = "nvim_lsp" },
        --     { name = "luasnip" },
        --     { name = "buffer" },
        --     { name = "path" },
        --     { name = "emoji" },
        --     { name = "dictionary", keyword_length = 2 },
        --   }),
        --   formatting = {
        --     format = function(_, item)
        --       local icons = require("lazyvim.config").icons.kinds
        --       if icons[item.kind] then
        --         item.kind = icons[item.kind] .. item.kind
        --       end
        --       return item
        --     end,
        --   },
        --   experimental = {
        --     ghost_text = {
        --       hl_group = "LspCodeLens",
        --     },
        --   },
        -- }
      end,
    },
  },
}
