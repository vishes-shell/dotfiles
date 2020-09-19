" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :close<cr>
nmap <leader>wq :wq<cr>
nmap <leader>o :only<cr>
nmap <leader>e :e<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return forward jumping
" unmap <C-i>


map <leader>tn :TestNearest<cr>
map <leader>tf :TestFile<cr>
" map <leader>ts :TestSuite<cr>
map <leader>tl :TestLast<cr>
map <leader>tv :TestVisit<cr>

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-h> <<
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
nmap <M-l> >>
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Tagbar settings
nmap <F8> :TagbarToggle<CR>

map <C-p> :Files<cr>
nnoremap <silent> <leader>? :History<cr>
nnoremap <silent> <leader>. :AgIn<space>
nnoremap <silent> ; :Buffers<cr>

nnoremap F :call SearchWordWithAg()<cr>
vnoremap <silent> F :call SearchVisualSelectionWithAg()<cr>
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
" nnoremap <silent> <leader>ft :Filetypes<CR>
nnoremap <silent> <leader>h :History:<CR>

noremap <leader>s :Ag<space>
noremap <leader>r :Commands<CR>
noremap <leader>c :History:<CR>

" Fugitive mapping
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>go :Git checkout<space>
nnoremap <leader>gpl :AsyncRun git pull<cr>
nnoremap <leader>gm :Gmerge origin/
nnoremap <leader>gt :Git tag<space>
nnoremap <leader>gph :AsyncRun git push<cr>
nnoremap <leader>gpt :Git push --tags<cr>
nnoremap <leader>gf :AsyncRun git fetch<cr>

nnoremap <leader>f :Vista finder<CR>

nnoremap <tab>   :tabnext<cr>
nnoremap <S-tab> :tabNext<cr>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

noremap  H  ^
noremap  L  $

noremap <C-U> kkkkkkkkkkkkkkkkkkkkk
noremap <C-D> jjjjjjjjjjjjjjjjjjjjj

" Make pressing Enter accept a completion entry.
function! SmartEnter()
    if pumvisible()
        return "\<C-y>"
    endif

    return "\<CR>"
endfunction

" Use Tab and Shift+Tab for either completion or SnipMate.
function! SmartTab() abort
    if pumvisible()
        let l:keys = "\<C-n>"

        if get(b:, 'ale_last_completion_count') is 1
            let l:keys .= "\<Left>\<Right>"
        endif

        return l:keys
    endif

    return snipMate#TriggerSnippet()
endfunction

function! SmartShiftTab() abort
    if pumvisible()
        return "\<C-p>"
    endif

    return snipMate#BackwardsSnippet()
endfunction

function! SmartInsertCompletion() abort
    if pumvisible()
        return "\<C-n>"
    endif

    return "\<C-c>a\<C-n>"
endfunction

inoremap <silent> <CR> <C-R>=SmartEnter()<CR>
inoremap <silent> <Tab> <C-R>=SmartTab()<CR>
inoremap <silent> <S-Tab> <C-R>=SmartShiftTab()<CR>
inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>
