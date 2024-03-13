set autowrite
set cinoptions=t0,:0
set formatoptions+=l
set mouse=a
set nu rnu
set path+=**,/usr/include/SDL2,/usr/local/include
set spelllang=en,pt
set splitright splitbelow
set title titlestring=\%(%m\ %)%t
set undofile

let g:c_no_curly_error = 1
let g:mapleader = ' '
let g:netrw_banner = 0
let g:netrw_winsize = 15

inoremap <C-s> <Cmd>update<CR>
noremap <C-s> <Cmd>update<CR>
inoremap <F5> <Cmd>silent make!<CR>
nnoremap <F5> <Cmd>silent make!<CR>
inoremap <F6> <Cmd>make!<CR>
nnoremap <F6> <Cmd>make<CR>
nnoremap <F7> <Cmd>prev<CR>
nnoremap <F8> <Cmd>n<CR>
nnoremap <C-n> <Cmd>cn<CR>
nnoremap <C-p> <Cmd>cp<CR>
vnoremap . :normal .<CR>
nnoremap <Leader>c <Cmd>set cursorline! cursorcolumn!<CR>
nnoremap <Leader>e <Cmd>Lex<CR>
nnoremap <Leader>o <Cmd>set spell!<CR>
nnoremap <Leader>s vip:sort<CR>
vnoremap <Leader>s <Cmd>sort<CR>

cnoremap <M-w> \<\><Left><Left>

nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>

nnoremap g1 :1wincmd w<CR>
nnoremap g2 :2wincmd w<CR>
nnoremap g3 :3wincmd w<CR>
nnoremap g4 :4wincmd w<CR>
nnoremap g5 :5wincmd w<CR>
nnoremap g6 :6wincmd w<CR>
nnoremap g7 :7wincmd w<CR>

nnoremap <Leader>1 :tabnext 1<CR>
nnoremap <Leader>2 :tabnext 2<CR>
nnoremap <Leader>3 :tabnext 3<CR>
nnoremap <Leader>4 :tabnext 4<CR>
nnoremap <Leader>5 :tabnext 5<CR>
nnoremap <Leader>6 :tabnext 6<CR>
nnoremap <Leader>7 :tabnext 7<CR>
nnoremap <Leader>8 :tabnext 8<CR>
nnoremap <Leader>9 :tabnext 9<CR>

colo okayokay
