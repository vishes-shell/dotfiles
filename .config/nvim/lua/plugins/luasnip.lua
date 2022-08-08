--
-----------------------------------------------------------
-- LuaSnip configuration file
-----------------------------------------------------------

-- Plugin: luasnip
-- url: https://github.com/L3MON4D3/LuaSnip

require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/lua/my_snippets"})
