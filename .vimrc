filetype plugin indent on
runtime ftplugin/man.vim

set nu rnu
set autowrite
set cinoptions=t0,:0,g0
set formatoptions+=l
set mouse=a
set path+=**,/usr/include/SDL2,/usr/local/include
set spelllang=en,pt
set splitright splitbelow
set title titlestring=\%(%m\ %)%t
set timeoutlen=1000 ttimeoutlen=50
set keywordprg=:Man
set wildmenu wildmode=list:longest,full
set modeline exrc secure
set noshowcmd
set textwidth=72
set guioptions=

" Undo setup!
if !isdirectory($HOME."/.vim")
	call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undodir")
	call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undofile undodir=~/.vim/undodir

let g:c_no_curly_error = 1
let g:mapleader = ' '
let g:netrw_banner = 0
let g:netrw_winsize = 15

inoremap <C-s> <cmd>update<cr>
noremap <C-s> <cmd>update<cr>
inoremap <F5> <cmd>make!<cr>
nnoremap <F5> <cmd>make!<cr>
nnoremap <F6> <cmd>prev<cr>
nnoremap <F7> <cmd>n<cr>
nnoremap <C-n> <cmd>cn<cr>
nnoremap <C-p> <cmd>cp<cr>
vnoremap . :normal .<cr>
nnoremap <leader>n <cmd>set nu! rnu!<cr>
nnoremap <leader>c <cmd>set cursorline! cursorcolumn!<cr>
nnoremap <leader>e <cmd>Lex<cr>
nnoremap <leader>o <cmd>set spell!<cr>
nnoremap <leader>g :vim "" **<left><left><left><left>
nnoremap <leader>T <cmd>vimgrep "\<TODO\>"**<cr>
nnoremap <leader>s vip:sort<cr>
vnoremap <leader>s <cmd>sort<cr>

nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

nnoremap g1 :1wincmd w<cr>
nnoremap g2 :2wincmd w<cr>
nnoremap g3 :3wincmd w<cr>
nnoremap g4 :4wincmd w<cr>
nnoremap g5 :5wincmd w<cr>
nnoremap g6 :6wincmd w<cr>
nnoremap g7 :7wincmd w<cr>

nnoremap <leader>1 :tabnext 1<cr>
nnoremap <leader>2 :tabnext 2<cr>
nnoremap <leader>3 :tabnext 3<cr>
nnoremap <leader>4 :tabnext 4<cr>
nnoremap <leader>5 :tabnext 5<cr>
nnoremap <leader>6 :tabnext 6<cr>
nnoremap <leader>7 :tabnext 7<cr>
nnoremap <leader>8 :tabnext 8<cr>
nnoremap <leader>9 :tabnext 9<cr>

au FileType c,cpp nnoremap <leader>p oprintf("%\n", );<esc>6hi

syn on
if hostname() == 'desktop1-win' ||
			\ hostname() == '530x' ||
			\ hostname() == 'localhost'
	colorscheme habamax
endif

function! g:PleaseRemoveMatchParen()
	set noshowmatch
	if exists(":NoMatchParen")
		:NoMatchParen
	endif
endfunction
augroup plugin_initialize
	autocmd!
	autocmd VimEnter * call PleaseRemoveMatchParen()
augroup END
