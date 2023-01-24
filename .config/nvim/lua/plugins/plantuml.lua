return {
  {
    "aklt/plantuml-syntax",
    lazy = true,
  },
  { "weirongxu/plantuml-previewer.vim",
    lazy = true,
    dependencies = { "tyru/open-browser.vim" },
    config = function()
      vim.cmd [[
        au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
            \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
            \  1,
            \  0
            \)
      ]]
    end
  }
}
