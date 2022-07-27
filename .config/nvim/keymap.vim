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
command NeoTestNearest lua require("neotest").run.run()
map <leader>tf :TestFile<cr>
command NeoTestFile lua require("neotest").run.run(vim.fn.expand("%"))
command NeoTestStopNearest lua require("neotest").run.stop()
map <leader>tr :lua require("neotest").output.open({ enter = true })
map <leader>ts :lua require("neotest").summary.open()
map <leader>tl :TestLast<cr>
map <leader>tv :TestVisit<cr>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-h> <<
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
nmap <M-l> >>
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

map <C-p> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <silent> <leader>? <cmd>lua require('fzf-lua').command_history()<CR>
nnoremap <silent> <leader>tt <cmd>Tags<CR>
nnoremap <silent> <leader>bt <cmd>Btags<CR>
nnoremap <silent> ; <cmd>lua require('fzf-lua').buffers()<CR>

nnoremap F <cmd>lua require('fzf-lua').grep_cword()<CR>
vnoremap <silent> F <cmd>lua require('fzf-lua').grep_visual()<CR>
nnoremap <silent> <leader>gl <cmd>lua require('fzf-lua').git_commits()<CR>
nnoremap <silent> <leader>ga <cmd>lua require('fzf-lua').git_bcommits()<CR>
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

noremap <leader>s :Find 
noremap <leader>l <cmd>lua require('fzf-lua').grep_curbuf()<CR>
nnoremap <leader><leader> <cmd>FzfLua<CR>

" Fugitive mapping
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gb :GBranches<cr>
nnoremap <leader>gpl :AsyncRun git pull<cr>
nnoremap <leader>gm :Gmerge origin/
nnoremap <leader>gph :AsyncRun git push<cr>
nnoremap <leader>gpr :AsyncRun git push -u origin HEAD<cr>
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

noremap <C-U> kkkkkkkkkkkkkkkkkkkkk
noremap <C-D> jjjjjjjjjjjjjjjjjjjjj

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
