" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :close<cr>
nmap <leader>wq :wq<cr>
nmap <leader>o :only<cr>

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


" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

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
nnoremap <silent> <Leader><Leader> :Files <C-R>=expand('%:h')<cr><cr>
nnoremap <silent> <leader>a :Buffers<cr>
nnoremap <silent> <leader>A :Windows<cr>
nnoremap <silent> <leader>? :History<cr>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<cr>
nnoremap <silent> <leader>. :AgIn<space>

nnoremap <silent> K :call SearchWordWithAg()<cr>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<cr>
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

noremap <leader>s :Ag<space>

" Fugitive mapping
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>go :Git checkout<space>
nnoremap <leader>gpl :AsyncRun git pull<cr>
nnoremap <leader>gm :Gmerge origin/
nnoremap <leader>gt :Git tag<space>
nnoremap <leader>gph :AsyncRun git push<cr>
nnoremap <leader>gpt :Git push --tags<cr>
nnoremap <leader>gf :AsyncRun git fetch<cr>

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
