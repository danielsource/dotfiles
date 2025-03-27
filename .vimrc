filetype plugin on

set nocompatible
set autoindent
set number relativenumber
set linebreak
set backspace=indent,eol,start
set splitright splitbelow
set showcmd ruler
set laststatus=1
set completeopt=menu,longest,preview
set path-=/usr/include, path+=src/**
set wildmenu wildmode=list:longest,full
set wildignore=*.o,*.obj,*.a,*.lib,*.so,*.dll,*.out,*.exe,*.class
set nrformats-=octal
set autowrite
set clipboard^=unnamed,unnamedplus
set title titlestring=%(%m\ %)%t
set directory=~/.vim/swap
set undofile undodir=~/.vim/undo

let loaded_matchparen=1
let g:netrw_banner=0
let g:sh_no_error=1

if !isdirectory($HOME.'/.vim/swap') | call mkdir($HOME.'/.vim/swap', 'p', 0700) | endif
if !isdirectory($HOME.'/.vim/undo') | call mkdir($HOME.'/.vim/undo', 'p', 0700) | endif

ino <C-s> <C-o>:update<CR>
nn <C-s> :update<CR>
nn <F5> :make<CR>
nn <Space>n :setlocal number! relativenumber!<CR>
nn <Space>0 :tabnext #<CR>
nn <Space>1 :tabnext 1<CR>
nn <Space>2 :tabnext 2<CR>
nn <Space>3 :tabnext 3<CR>
nn <Space>4 :tabnext 4<CR>
nn <Space>5 :tabnext 5<CR>
nn <Space>6 :tabnext 6<CR>
nn <Space>7 :tabnext 7<CR>
nn <Space>8 :tabnext 8<CR>
nn <Space>9 :tabnext $<CR>
nn g1 :1wincmd w<CR>
nn g2 :2wincmd w<CR>
nn g3 :3wincmd w<CR>
nn g4 :4wincmd w<CR>
nn g5 :5wincmd w<CR>
nn g6 :6wincmd w<CR>

command DiffOrig vert new | set bt=nofile | file # (diff)
	\ | r ++edit #
	\ | 0d_ | diffthis | wincmd p | diffthis

augroup ftprefs
	au!
	au BufNewFile,BufRead *.c,*.h setlocal path+=/usr/local/include,/usr/include
augroup END

if has('syntax')
	syntax on
	colorscheme habamax
	hi Normal ctermbg=NONE
endif
