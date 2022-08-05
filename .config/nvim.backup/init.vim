let s:config_dir = expand('<sfile>:p:h')
" let s:config_dir = "~/.dotfiles/config/nvim"

set termguicolors
execute("source " . s:config_dir . "/plugins.vim")
execute("source " . s:config_dir . "/settings.vim")
execute("source " . s:config_dir . "/functions.vim")
execute("source " . s:config_dir . "/keymap.vim")
execute("source " . s:config_dir . "/ab.vim")

filetype plugin indent on
syntax enable

set exrc  " Enable project-specific vimrc
