-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd('iabbrev serialziers serializers')
vim.cmd('iabbrev reponse response')
vim.cmd('iabbrev profesion profession')
vim.cmd('iabbrev professsion profession')
vim.cmd('iabbrev profesions professions')
vim.cmd('iabbrev professsions professions')
vim.cmd('iabbrev <expr> nowd strftime("%Y-%m-%d")')
vim.cmd('iabbrev <expr> nowdt strftime("%Y-%m-%d %H:%M:%S")')

vim.cmd([[
  augroup lexical
    autocmd!
    autocmd FileType markdown,mkd call lexical#init()
    autocmd FileType textile call lexical#init()
    autocmd FileType text call lexical#init({ 'spell': 0 })
  augroup END

  let g:lexical#spelllang = ['en_us','en_ca', 'en_gb','ru_ru']
]])

vim.api.nvim_exec([[
function! s:prepend_task_number() abort
    let task = system('git symbolic-ref --short HEAD | awk -F "[/-]" ''{printf "%s-%s ",$2,$3}''')
    if l:task != ' - '
        call append(line('.'), l:task)
        normal! J
        normal! 0
    endif
endfunction
autocmd BufRead */.git/COMMIT_EDITMSG call s:prepend_task_number()
]], true)
