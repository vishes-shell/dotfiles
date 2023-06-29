return {
  -- any list will do
  {
    "gaoDean/autolist.nvim",
    enabled = false,
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
    },
    config = function()
      local autolist = require("autolist")
      autolist.setup()
      autolist.create_mapping_hook("i", "<CR>", autolist.new)
      autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
      autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
      autolist.create_mapping_hook("n", "o", autolist.new)
      autolist.create_mapping_hook("n", "O", autolist.new_before)
      autolist.create_mapping_hook("n", ">>", autolist.indent)
      autolist.create_mapping_hook("n", "<<", autolist.indent)
      autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
      autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
      vim.api.nvim_create_autocmd("TextChanged", {
        pattern = "*",
        callback = function()
          vim.cmd.normal({ autolist.force_recalculate(nil, nil), bang = false })
        end,
      })
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
  -- better % matching
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
  -- better join lines
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  -- renamin like never before
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sR",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
  {
    "echasnovski/mini.surround",
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
  -- {
  --   "gbprod/yanky.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   enabled = true,
  --   event = "BufReadPost",
  --   config = function()
  --     require("yanky").setup({
  --       highlight = {
  --         timer = 150,
  --       },
  --       ring = {
  --         storage = jit.os:find("Windows") and "shada" or "sqlite",
  --       },
  --     })
  --
  --     vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
  --
  --     vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  --     vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  --     vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  --     vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  --
  --     vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
  --     vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
  --
  --     vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
  --     vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
  --     vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
  --     vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
  --
  --     vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
  --     vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
  --
  --     vim.keymap.set("n", "<leader>P", function()
  --       require("telescope").extensions.yank_history.yank_history({})
  --     end, { desc = "Paste from Yanky" })
  --   end,
  -- },
  { "LunarVim/bigfile.nvim" },
}
