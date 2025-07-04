filetype plugin indent on

set nocompatible
set tabstop=8 shiftwidth=8 noexpandtab
set formatoptions+=lj cinoptions=c0,t0,:0,g0
set number relativenumber
set backspace=indent,eol,start
set splitright splitbelow
set scrolloff=0
set display=uhex,truncate isprint=
set listchars=eol:$,tab:<->,space:.
set showcmd ruler rulerformat=%10(%v%=\ %P%)
set laststatus=1
set hlsearch incsearch
set completeopt=menu,longest,preview
set path-=/usr/include, path+=src/**
set wildmenu wildmode=list:longest,full
set wildignore=*.o,*.obj,*.a,*.lib,*.so,*.dll,*.out,*.exe,*.class
set history=1000
set nrformats-=octal
set title titlestring=%(%m\ %)%t
set autowrite
set undofile
set noexrc secure
set ttimeout ttimeoutlen=100
set mouse=a

let g:netrw_banner=0
let g:sh_no_error=1
let g:mapleader=' '

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

nn <Leader>it a<C-r>=strftime("%Y-%m-%d %H:%M %Z")<CR><Esc>

command DiffOrig vert new | set bt=nofile | file # (diff)
	\ | r ++edit #
	\ | 0d_ | diffthis | wincmd p | diffthis

augroup ftprefs
	au!
	au BufNewFile,BufRead *.c,*.h setlocal path+=~/opt/include,/usr/local/include,/usr/include,/usr/include/x86_64-linux-gnu,/usr/lib/gcc/x86_64-linux-gnu/*/include
augroup END

if !has('nvim')
	runtime ftplugin/man.vim
	set keywordprg=:Man

	if !isdirectory($HOME..'/.vim/swap')
		call mkdir($HOME..'/.vim/swap', 'p', 0700)
	endif
	if !isdirectory($HOME..'/.vim/undo')
		call mkdir($HOME..'/.vim/undo', 'p', 0700)
	endif
	set directory=~/.vim/swap// undodir=~/.vim/undo viminfo+=n~/.vim/viminfo

	nn <silent> <C-l> :nohlsearch<C-r>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-l>

	syntax on
	set bg=dark
	augroup colors
		au!
		au ColorScheme * hi Normal ctermbg=NONE
		au ColorScheme * hi! link SpecialKey Comment
	augroup END
	colorscheme habamax

	if filereadable($HOME..'/.vimrc.local')
		source ~/.vimrc.local
	endif
endif
