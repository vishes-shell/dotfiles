local autocmd = vim.api.nvim_create_autocmd

local augroup = vim.api.nvim_create_augroup("all", { clear = true })

autocmd('FileType', { group = augroup, pattern = "lua", command = "setlocal softtabstop=2" })
autocmd('FileType', { group = augroup, pattern = "lua", command = "setlocal tabstop=2" })


autocmd("FileType", { group = augroup, pattern = "gitcommit", command = "setlocal nolist" })

autocmd("FileType", { group = augroup, pattern = "markdown", command = "setlocal softtabstop=2" })
autocmd("FileType", { group = augroup, pattern = "markdown", command = "setlocal tabstop=2" })

vim.api.nvim_exec(
[[
function! s:prepend_task_number() abort
    let task = system('git symbolic-ref --short HEAD | awk -F "[/-]" ''{printf "%s-%s ",$2,$3}''')
    if l:task != '- '
        call append(line('.'), l:task)
        normal! J
    endif
endfunction
autocmd BufRead */.git/COMMIT_EDITMSG call s:prepend_task_number()
]],
true)
