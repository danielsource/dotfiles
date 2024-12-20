filetype plugin indent on

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
set laststatus=1
set title titlestring=\%(%m\ %)%t
set history=1000
set mouse=a
set undofile
set nomodeline noexrc secure
set spelllang=en,pt_br

let g:netrw_banner = 0
let g:netrw_cursor = 0
let g:c_no_curly_error = 1
let g:sh_no_error = 1
let loaded_matchparen = 1
let loaded_netrw = 1
let loaded_netrwPlugin = 1

let g:mapleader = ' '

nnoremap <silent> <F1> :make!<CR>
nnoremap <silent> <F2> <Nop>
nnoremap <silent> <F3> <Nop>
nnoremap          <F4> :set spell!<CR>
nnoremap <silent> <C-S> :update<CR>

nnoremap <silent> g1 :silent! 1wincmd w<CR>
nnoremap <silent> g2 :silent! 2wincmd w<CR>
nnoremap <silent> g3 :silent! 3wincmd w<CR>
nnoremap <silent> g4 :silent! 4wincmd w<CR>
nnoremap <silent> g5 :silent! 5wincmd w<CR>
nnoremap <silent> g6 :silent! 6wincmd w<CR>
nnoremap <silent> g7 :silent! 7wincmd w<CR>

nnoremap <silent> <Leader>1 :silent! :tabnext 1<CR>
nnoremap <silent> <Leader>2 :silent! :tabnext 2<CR>
nnoremap <silent> <Leader>3 :silent! :tabnext 3<CR>
nnoremap <silent> <Leader>4 :silent! :tabnext 4<CR>
nnoremap <silent> <Leader>5 :silent! :tabnext 5<CR>
nnoremap <silent> <Leader>6 :silent! :tabnext 6<CR>
nnoremap <silent> <Leader>7 :silent! :tabnext 7<CR>
nnoremap <silent> <Leader>8 :silent! :tabnext 8<CR>
nnoremap <silent> <Leader>9 :silent! :tabnext 9<CR>

if !exists(':DiffOrig')
	command DiffOrig vert new | set bt=nofile | file # (diff)
		\ | r ++edit #
		\ | 0d_ | diffthis | wincmd p | diffthis
endif

autocmd! BufRead,BufNewFile *.inc set ft=cpp

if !has('nvim')
	set keywordprg=:Man
	runtime ftplugin/man.vim

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

if filereadable($HOME.'/docs/vimrc')
	execute 'source '.$HOME.'/docs/vimrc'
else
	runtime mycolors.vim
endif
