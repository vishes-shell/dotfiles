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
noremap <leader>l :BLines<CR>
noremap <leader>t :BTags<CR>
noremap <leader>r :Commands<CR>
noremap <leader>c :History:<CR>

" Fugitive mapping
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :GBranches<cr>
nnoremap <leader>gpl :AsyncRun git pull<cr>
nnoremap <leader>gm :Gmerge origin/
nnoremap <leader>gph :AsyncRun git push<cr>
nnoremap <leader>gpr :AsyncRun git push -u origin HEAD<cr>
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

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
