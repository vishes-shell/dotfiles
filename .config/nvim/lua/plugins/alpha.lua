return { {
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
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New Note", [[:lua require('telekasten').new_note() <cr>]]),
      dashboard.button("t", " " .. " Today Note", [[:lua require('telekasten').goto_today() <cr>]]),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
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
  end
} }
