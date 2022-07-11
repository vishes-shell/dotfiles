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

com! FormatJSON %!python3.9 -m json.tool --no-ensure-ascii
com! FormatSQL %!sqlformat --keywords upper --identifiers lower --reindent --use_space_around_operators -

command! -nargs=0 RemoveStringWrap .s/str(\([a-zA-Z._]*\))/\1/

command! GpushNew :Gpush origin -u HEAD

nnoremap <C-b> :center 80<cr>hhv0r#A<space><esc>40A#<esc>d80<bar>YppVr#kk.
