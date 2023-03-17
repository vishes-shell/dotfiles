return {
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
}
