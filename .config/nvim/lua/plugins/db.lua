return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    "tpope/vim-dotenv",
  },
  keys = {
    { "<leader>db", "<cmd>DBUI<cr>", desc = "Open Database client" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_force_echo_notifications = 0
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_winwidth = 30

    vim.g.db_ui_icons = {
      expanded = {
        db = "▾ ",
        buffers = "▾ ",
        saved_queries = "▾ ",
        schemas = "▾ ",
        schema = "▾ פּ",
        tables = "▾ 藺",
        table = "▾ ",
      },
      collapsed = {
        db = "▸ ",
        buffers = "▸ ",
        saved_queries = "▸ ",
        schemas = "▸ ",
        schema = "▸ פּ",
        tables = "▸ 藺",
        table = "▸ ",
      },
      saved_query = "",
      new_query = "璘",
      tables = "離",
      buffers = "﬘",
      add_connection = "",
      connection_ok = "✓",
      connection_error = "✕",
    }
  end,
}
