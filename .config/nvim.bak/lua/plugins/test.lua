-----------------------------------------------------------
-- Test configuration file
-----------------------------------------------------------

-- Plugin: test
-- url: https://github.com/vim-test/vim-test

vim.g['test#strategy'] = 'neovim'

vim.g['test#preserve_screen'] = 1
vim.g['test#neovim#start_normal'] = 1

vim.g['test#python#runner'] = 'pytest'

vim.g['test#python#pytest#options'] = '--reuse-db --color=yes'
