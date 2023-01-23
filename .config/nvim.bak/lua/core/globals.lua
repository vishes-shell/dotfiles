-- Change leader to a space
vim.g.mapleader = ' '
vim.g.localleader = ' '

vim.g.python3_host_prof = '/usr/local/bin/python3'

vim.g.XkbSwitchEnabled = 1

vim.g.completeopt = "menu,menuone,noselect,noinsert"

vim.cmd [[
au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)
]]
