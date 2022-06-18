" leader
let mapleader = ';'

" repeat find-in-line
nnoremap <Leader>; ;

" [c]lear search highlight
nnoremap <silent><Leader>c :let @/=""<CR>

" [s]pell
nnoremap <silent><C-S> :setlocal spell!<CR>

" [+][-] resize window splits
nnoremap + :vertical resize +25<CR>
nnoremap _ :vertical resize -25<CR>
nnoremap [ :horizontal resize +25<CR>
nnoremap ] :horizontal resize -25<CR>

nnoremap <Leader>\ :vnew<CR>

" fluid vim navigation for splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
tnoremap <C-L> <C-W><C-L>
vnoremap <C-L> <C-W><C-L>
inoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
tnoremap <C-H> <C-W><C-H>
vnoremap <C-H> <C-W><C-H>
inoremap <C-H> <C-W><C-H>


" write buffer
nnoremap <Leader><ENTER> :silent! w<CR>

" [d]elete current buffer
nnoremap <silent><Leader>d :silent! bd<CR>

" [q]uit vim
nnoremap <silent><Leader>q :silent! q!<CR>

" cycle to previous buffer
nnoremap <silent><S-Tab> :silent! bN<CR>

" cycle to next buffer
nnoremap <silent><leader><Tab> :silent! bn<CR>

" source .vimrc
nnoremap <silent><Leader>$ :source $MYVIMRC<Bar>echo 'done!'<CR>

" swap # and * & search from word under cursor
nnoremap # :keepjumps normal! mi*`i<CR>

" [r]eload buffer
nnoremap <silent><Leader>0 :edit! <CR>
