set nocompatible
set sts=4 sw=4 et ai
set backspace=indent,eol,start
set splitright splitbelow
set showcmd ruler
set laststatus=1
set completeopt=menu,longest,preview
set wildmenu wildmode=list:longest,full
set nrformats-=octal
set autowrite
set clipboard^=unnamed,unnamedplus

if 1
    let g:netrw_banner=0
    let loaded_matchparen=1
endif

nn <f5> :make<cr>
nn <space>n :setlocal number! relativenumber!<cr>
nn <space>0 :tabnext #<CR>
nn <space>1 :tabnext 1<CR>
nn <space>2 :tabnext 2<CR>
nn <space>3 :tabnext 3<CR>
nn <space>4 :tabnext 4<CR>
nn <space>5 :tabnext 5<CR>
nn <space>6 :tabnext 6<CR>
nn <space>7 :tabnext 7<CR>
nn <space>8 :tabnext 8<CR>
nn <space>9 :tabnext $<CR>
nn g1 :1wincmd w<CR>
nn g2 :2wincmd w<CR>
nn g3 :3wincmd w<CR>
nn g4 :4wincmd w<CR>
nn g5 :5wincmd w<CR>
nn g6 :6wincmd w<CR>

if has('syntax')
    syntax on
    colorscheme habamax
endif
