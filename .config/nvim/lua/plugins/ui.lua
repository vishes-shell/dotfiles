return {
  -- welcome window
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
      ██╗   ██╗███████╗███████╗    ██╗████████╗███████╗    ██╗   ██╗██╗███╗   ███╗
      ╚██╗ ██╔╝██╔════╝██╔════╝    ██║╚══██╔══╝██╔════╝    ██║   ██║██║████╗ ████║
       ╚████╔╝ █████╗  ███████╗    ██║   ██║   ███████╗    ██║   ██║██║██╔████╔██║
        ╚██╔╝  ██╔══╝  ╚════██║    ██║   ██║   ╚════██║    ╚██╗ ██╔╝██║██║╚██╔╝██║
         ██║   ███████╗███████║    ██║   ██║   ███████║     ╚████╔╝ ██║██║ ╚═╝ ██║
         ╚═╝   ╚══════╝╚══════╝    ╚═╝   ╚═╝   ╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file", [[:lua require("genghis").createNewFile() <cr>]]),
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("/", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button(
          "z",
          " " .. " New Note",
          [[:lua vim.ui.input({prompt="Title"}, function(title) if title then require("zk").new({title=title}) end end) <cr>]]
        ),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local colors = require("catppuccin.palettes").get_palette()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
            InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
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
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = false,
        kitty = { enabled = true, font = "+2" },
      },
    },
    keys = { { "<leader>wz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}