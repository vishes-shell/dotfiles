-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.XkbSwitchEnabled = 1

vim.g.gutentags_file_list_command = 'fd'
vim.g.gutentags_ctags_extra_args = { '--languages=python', '--kinds-python=-iv' }
vim.g.gutentags_ctags_tagfile = 'tags'
vim.g.gutentags_file_list_command = "fd --hidden --strip-cwd-prefix --type f -E .git -E .venv"
