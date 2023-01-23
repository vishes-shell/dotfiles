--
-----------------------------------------------------------
-- Lexical configuration file
-----------------------------------------------------------

-- Plugin: lexical
-- url: https://github.com/preservim/vim-lexical

vim.cmd(
[[
augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END

let g:lexical#spelllang = ['en_us','en_ca', 'en_gb','ru_ru']
]]
)
