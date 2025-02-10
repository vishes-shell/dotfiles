-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.g.XkbSwitchEnabled = 1
vim.g.XkbSwitchLib = "/usr/local/bin/libxkbswitch.dylib"

vim.g.gutentags_file_list_command = "fd"
vim.g.gutentags_ctags_extra_args = { "--languages=python", "--kinds-python=-iv" }
vim.g.gutentags_ctags_tagfile = "tags"
vim.g.gutentags_file_list_command = "fd --hidden --strip-cwd-prefix --type f -E .git -E .venv"

opt.conceallevel = 0

opt.spelllang = { "en_us", "ru" }

vim.g.python3_host_prog = "/opt/homebrew/bin/python3.11"
vim.opt.shell = "/usr/local/bin/fish"

vim.g.lazyvim_picker = "snacks"
