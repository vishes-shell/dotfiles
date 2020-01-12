function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf_layout))
endfunction

function! s:prepend_task_number() abort
    let task = system('git symbolic-ref --short HEAD | awk -F "[/-]" ''{printf "%s-%s ",$2,$3}''')
    if l:task != '- '
        call append(line('.'), l:task)
        normal! J
    endif
endfunction
autocmd BufRead */.git/COMMIT_EDITMSG call s:prepend_task_number()

command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

com! FormatJSON %!python -m json.tool

command! -nargs=0 RemoveStringWrap .s/str(\([a-zA-Z._]*\))/\1/
