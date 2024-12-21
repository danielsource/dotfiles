filetype plugin indent on
syntax on

set fileformats=unix,dos fileformat=unix
set tabstop=8 shiftwidth=8 noexpandtab
set number relativenumber
set textwidth=74 formatoptions+=lj
set incsearch hlsearch
set autowrite
set splitright splitbelow
set completeopt=menuone,preview,longest
set wildmenu wildmode=list:longest,full
set ruler showcmd
set nrformats-=octal
set cinoptions=c0,t0,:0,g0
set title titlestring=\%(%m\ %)%t
set history=1000
set mouse=a
set undofile
set modeline noexrc secure

let g:netrw_banner = 0
let g:c_no_curly_error = 1
let loaded_matchparen = 1

let g:mapleader = ' '
nnoremap <leader>n :set nu! rnu!<cr>
nnoremap <silent> <leader>1 :silent! :tabnext 1<cr>
nnoremap <silent> <leader>2 :silent! :tabnext 2<cr>
nnoremap <silent> <leader>3 :silent! :tabnext 3<cr>
nnoremap <silent> <leader>4 :silent! :tabnext 4<cr>
nnoremap <silent> <leader>5 :silent! :tabnext 5<cr>
nnoremap <silent> <leader>6 :silent! :tabnext 6<cr>
nnoremap <silent> <leader>7 :silent! :tabnext 7<cr>
nnoremap <silent> <leader>8 :silent! :tabnext 8<cr>
nnoremap <silent> <leader>9 :silent! :tabnext 9<cr>

autocmd! BufRead,BufNewFile *.inc set ft=cpp
autocmd! FileType c,cpp nnoremap <leader>m i#include<space>"u.h"<cr><cr>int<cr>main(int<space>argc,<space>char<space>*argv[])<cr>{<cr>if<space>(argc<space>!=<space>2)<cr>return 1;<cr>return<space>0;<cr>}<esc>8k

if !has('nvim')
	if !isdirectory($HOME.'/.vim')
		call mkdir($HOME.'/.vim', '', 0770)
	endif
	if !isdirectory($HOME.'/.vim/swap')
		call mkdir($HOME.'/.vim/swap', '', 0700)
	endif
	if !isdirectory($HOME.'/.vim/undo')
		call mkdir($HOME.'/.vim/undo', '', 0700)
	endif
	set viminfo+=n~/.vim/viminfo directory=~/.vim/swap// undodir=~/.vim/undo/

	if maparg('<C-L>', 'n') ==# ''
		nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
	endif

	set ttimeoutlen=50
endif

if has('termguicolors') && $TERM !~# '^screen.*'
	try
		colorscheme eighties
		set termguicolors
	catch /^Vim\%((\a\+)\)\=:E185:/
		colorscheme slate
	endtry
else
	colorscheme slate
endif

set keywordprg=:Man
runtime ftplugin/man.vim
