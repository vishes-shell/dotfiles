--
-----------------------------------------------------------
-- Gutentags configuration file
-----------------------------------------------------------

-- Plugin: gutentags
-- url: https://github.com/ludovicchabant/vim-gutentags

vim.g.gutentags_file_list_command = 'fd'
vim.g.gutentags_ctags_extra_args = { '--languages=python', '--kinds-python=-iv' }
vim.g.gutentags_ctags_tagfile = 'tags'
vim.g.gutentags_file_list_command = "fd --hidden --strip-cwd-prefix --type f -E .git -E .venv"
