set nocompatible
set sts=4 sw=4 et ai
set number relativenumber
set wrap linebreak
set splitright splitbelow
set showcmd ruler
set laststatus=1
set completeopt=menu,longest,preview
set wildmenu wildmode=list:longest,full
set nrformats-=octal
set autowrite
set clipboard^=unnamed,unnamedplus
let g:netrw_banner=0
let loaded_matchparen=1

let g:mapleader = ' '
nn <f5> :make<cr>
nn <leader>n :setlocal number! relativenumber!<cr>
nn <leader>' :tabnext #<CR>
nn <leader>1 :tabnext 1<CR>
nn <leader>2 :tabnext 2<CR>
nn <leader>3 :tabnext 3<CR>
nn <leader>4 :tabnext 4<CR>
nn <leader>5 :tabnext 5<CR>
nn <leader>6 :tabnext 6<CR>
nn <leader>7 :tabnext 7<CR>
nn <leader>8 :tabnext 8<CR>
nn <leader>9 :tabnext $<CR>
nn g1 :1wincmd w<CR>
nn g2 :2wincmd w<CR>
nn g3 :3wincmd w<CR>
nn g4 :4wincmd w<CR>
nn g5 :5wincmd w<CR>
nn g6 :6wincmd w<CR>
nn g7 :7wincmd w<CR>

syntax on
if has('termguicolors')
    set termguicolors
    colorscheme habamax
endif
