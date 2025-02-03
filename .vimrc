filetype plugin indent on
syntax on

set fileformats=unix,dos fileformat=unix
set tabstop=8 shiftwidth=8 noexpandtab
set number relativenumber
set textwidth=74 formatoptions+=lj
set incsearch hlsearch
set autowrite
set splitright splitbelow
set wildmenu wildmode=list:longest,full
set ruler showcmd
set nrformats-=octal
set cinoptions=t0,:0,g0
set title titlestring=\%(%m\ %)%t
set history=1000
set mouse=a
set undofile
set modeline noexrc secure

set keywordprg=:Man
runtime ftplugin/man.vim

let g:netrw_banner = 0
let g:c_no_curly_error = 1
let loaded_matchparen = 1

let g:mapleader = ' '
nn <leader>1 :tabnext 1<cr>
nn <leader>2 :tabnext 2<cr>
nn <leader>3 :tabnext 3<cr>
nn <leader>4 :tabnext 4<cr>
nn <leader>5 :tabnext 5<cr>
nn <leader>6 :tabnext 6<cr>
nn <leader>7 :tabnext 7<cr>
nn <leader>8 :tabnext 8<cr>
nn <leader>9 :tabnext 9<cr>

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
