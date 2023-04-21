return {
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>fp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        desc = "Peek (Markdown Preview)",
      },
    },
    opts = { theme = "light" },
  },
  {
    "weirongxu/plantuml-previewer.vim",
    lazy = true,
    dependencies = { "tyru/open-browser.vim" },
    config = function()
      vim.cmd([[
        au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
            \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
            \  1,
            \  0
            \)
      ]])
    end,
  },
}
