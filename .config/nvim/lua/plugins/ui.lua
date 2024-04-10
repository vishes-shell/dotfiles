return {
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(string.rep("\n", 8) .. [[
            _   _                     _                                                    
           | |_| |__   ___ _ __ ___  (_)___   _ __   ___     ___  ___  ___ __ _ _ __   ___ 
           | __| '_ \ / _ \ '__/ _ \ | / __| | '_ \ / _ \   / _ \/ __|/ __/ _` | '_ \ / _ \
           | |_| | | |  __/ | |  __/ | \__ \ | | | | (_) | |  __/\__ \ (_| (_| | |_) |  __/
            \__|_| |_|\___|_|  \___| |_|___/ |_| |_|\___/   \___||___/\___\__,_| .__/ \___|
                                                                                |_|        
          ]] .. "\n\n", "\n"),
        center = {
          { action = 'lua require("genghis").createNewFile()', desc = "New file", icon = " ", key = "n" },
          { action = "Telescope find_files", desc = "Find file", icon = " ", key = "f" },
          { action = "Telescope live_grep", desc = "Find text", icon = " ", key = "/" },
          {
            action = 'lua vim.ui.input({prompt="Title"}, function(title) if title then require("zk").new({title=title}) end end)',
            desc = "New note",
            icon = " ",
            key = "z",
          },
          { action = "Telescope oldfiles", desc = "Recent files", icon = " ", key = "r" },
          { action = "Lazy", desc = "Lazy", icon = "鈴", key = "l" },
          { action = "qa", desc = "Quit", icon = " ", key = "q" },
        },
      },
    },
  },
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
  { "mracos/mermaid.vim" },
}
