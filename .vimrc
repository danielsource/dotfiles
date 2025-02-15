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
let g:netrw_cursor = 0
let g:c_no_curly_error = 1
let loaded_matchparen = 1

let g:mapleader = ' '

nnoremap <silent> g1 :silent! 1wincmd w<cr>
nnoremap <silent> g2 :silent! 2wincmd w<cr>
nnoremap <silent> g3 :silent! 3wincmd w<cr>
nnoremap <silent> g4 :silent! 4wincmd w<cr>
nnoremap <silent> g5 :silent! 5wincmd w<cr>
nnoremap <silent> g6 :silent! 6wincmd w<cr>
nnoremap <silent> g7 :silent! 7wincmd w<cr>

nnoremap <silent> <Leader>1 :silent! :tabnext 1<CR>
nnoremap <silent> <Leader>2 :silent! :tabnext 2<CR>
nnoremap <silent> <Leader>3 :silent! :tabnext 3<CR>
nnoremap <silent> <Leader>4 :silent! :tabnext 4<CR>
nnoremap <silent> <Leader>5 :silent! :tabnext 5<CR>
nnoremap <silent> <Leader>6 :silent! :tabnext 6<CR>
nnoremap <silent> <Leader>7 :silent! :tabnext 7<CR>
nnoremap <silent> <Leader>8 :silent! :tabnext 8<CR>
nnoremap <silent> <Leader>9 :silent! :tabnext 9<CR>

autocmd! BufRead,BufNewFile *.inc set ft=cpp
autocmd! FileType c,cpp nnoremap <Leader>m i#include<Space>"u.h"<CR><CR>int<CR>main(int<Space>argc,<Space>char<Space>*argv[])<CR>{<CR>if<Space>(argc<Space>!=<Space>2)<CR>return 1;<CR>return<Space>0;<CR>}<Esc>8k

set keywordprg=:Man
runtime ftplugin/man.vim

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

colorscheme process
