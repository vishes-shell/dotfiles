return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = { view = "mini" },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      animate = { enabled = true },
      dim = { enabled = true },
      explorer = { enabled = true },
      git = { enabled = true },
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      scratch = { enabled = true },
      words = { enabled = true },
      lazygit = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      rename = { enabled = true },
      scroll = { enabled = true },
      toggle = { enabled = true },
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
          explorer = {
            hidden = true,
          },
        },
      },
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua require('fff').find_files()" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "terminal", cmd = "fortune -s | cowsay", hl = "header", padding = 1, indent = 8 },
          { title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          { section = "recent_files", cwd = true, limit = 8, padding = 1 },
          { section = "keys" },
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          require("fff").find_files()
        end,
        desc = "Find Files",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  "sphamba/smear-cursor.nvim",
}
