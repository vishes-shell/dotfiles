return {
  -- any list will do
  {
    "gaoDean/autolist.nvim",
    enabled = true,
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
    },
    config = function()
      require("autolist").setup({
        colon = { indent_raw = false },
        cycle = { "-", "1." },
      })

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      vim.keymap.set("n", "<leader>x", "<cmd>AutolistToggleCheckbox<cr>")
      vim.keymap.set("n", "<leader>r", "<cmd>AutolistRecalculate<cr>")

      -- vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
      -- vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },
  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%d.%m.%Y"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },
  -- f-string for python
  {
    "roobert/f-string-toggle.nvim",
    keys = {
      {
        "<leader>fs",
        function()
          require("f-string-toggle").toggle_fstring()
        end,
        desc = "Toffle f-string",
      },
    },
  },
  -- better join lines
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "cs",
        update_n_lines = "",
        suffix_last = "N",
        suffix_next = "n",
      },
      n_lines = 50,
      search_method = "cover_or_next",
    },
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    init = function()
      local custom_surroundings = {
        markdown = {
          ["B"] = { -- Surround for bold
            input = { "%*%*().-()%*%*" },
            output = { left = "**", right = "**" },
          },
          ["I"] = { -- Surround for italics
            input = { "%_().-()%_" },
            output = { left = "_", right = "_" },
          },
          ["M"] = { -- Surround for monospace
            input = { "%`().-()%`" },
            output = { left = "`", right = "`" },
          },
          ["L"] = {
            input = { "%[().-()%]%([^)]+%)" },
            output = function()
              local href = require("mini.surround").user_input("Href")
              return {
                left = "[",
                right = "](" .. href .. ")",
              }
            end,
          },
          ["R"] = {
            input = { "%[().-()%]%[[^)]+%]" },
            output = function()
              local label = require("mini.surround").user_input("Label")
              return {
                left = "[",
                right = "][" .. label .. "]",
              }
            end,
          },
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dotfiles-mini_surround", {}),
        pattern = vim.fn.join(vim.tbl_keys(custom_surroundings), ","),
        callback = function()
          local ft = vim.opt.filetype:get()
          vim.b.minisurround_config = {
            custom_surroundings = custom_surroundings[ft],
          }
        end,
      })
    end,
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>ds",
        function()
          require("neogen").generate({})
        end,
      },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
      },
    },
  },
  {
    "dhruvasagar/vim-table-mode",
    config = function()
      vim.g.table_mode_corner = "|"
    end,
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode" },
    },
  },
  {
    "lyokha/vim-xkbswitch",
    lazy = false,
  },
  { "LunarVim/bigfile.nvim" },
  { "lambdalisue/suda.vim" },
  {
    "MagicDuck/grug-far.nvim",
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
      })
    end,
  },
}
