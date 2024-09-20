" daniel.source's humble vim config (no external plugins).

filetype plugin indent on

" Indentation (4 spaces)
set sts=4 sw=4 et

" Set maximum text width but don't annoy me with already long lines.
set textwidth=74 formatoptions+=l

" Line numbers (relative to jump quickly, idk if this is really useful...)
set number relativenumber

" Search while typing and highlight it
set incsearch hlsearch

" Save file before :make or etc.
set autowrite

" C indentation: don't indent return type, nor case labels, nor C++ labels
set cinoptions=t0,:0,g0

" For file and identifier autocompletion (use only if you know wyd!)
set path+=**,/usr/include/SDL2,/usr/local/include

" Sensible window splitting
set splitright splitbelow

" Sensible command-line mode menu
set wildmenu wildmode=list:longest,full

" I think I need this because of tmux
set timeoutlen=1000 ttimeoutlen=50

" Enable manual
set keywordprg=:Man
runtime ftplugin/man.vim

" Do what I mean when {in,de}crementing numbers with leading zeroes
set nrformats-=octal

" Trick vim to disable matching parenthesis (I this find distracting)
let loaded_matchparen = 1

" Setup spellchecking
set spelllang=en_us,pt_br
set spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/pt.utf-8.add

" Miscellaneous
set noshowcmd " 'showcmd' is buggy for me.
set modeline exrc secure
set history=1000
set title titlestring=\%(%m\ %)%t
set mouse=a
set guioptions=
let g:c_no_curly_error = 1
let g:netrw_banner = 0
let g:netrw_winsize = 15

" Put "temporary" files in ~/.vim
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "", 0700)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif
set directory=~/.vim/swap// undofile undodir=~/.vim/undo/ " Enable cool undo saving!

"
" Keybindings
"

let g:mapleader = ' '

ino <C-s> <cmd>update<cr>
no  <C-s> <cmd>update<cr>
ino <f5> <cmd>make!<cr>
nn  <f5> <cmd>make!<cr>
nn <f6> <cmd>previous<cr>
nn <f7> <cmd>next<cr>
nn <C-n> <cmd>cnext<cr>
nn <C-p> <cmd>cprevious<cr>
vn . :normal .<cr>
nn <leader>n <cmd>setl relativenumber!<cr>
nn <leader>c <cmd>setl cursorline! cursorcolumn!<cr>
nn <leader>C <cmd>let &l:colorcolumn = &l:textwidth + 1<cr>
nn <leader>e <cmd>Lexplore<cr>
nn <leader>o <cmd>setl spell!<cr>
nn <leader>g :vimgrep // **<left><left><left><left>
nn <leader>s vip:sort<cr>
vn <leader>s <cmd>sort<cr>
nn <leader>u /[^\x00-\x7F]<cr>

nn <leader>h :wincmd h<cr>
nn <leader>j :wincmd j<cr>
nn <leader>k :wincmd k<cr>
nn <leader>l :wincmd l<cr>

nn g1 :1wincmd w<cr>
nn g2 :2wincmd w<cr>
nn g3 :3wincmd w<cr>
nn g4 :4wincmd w<cr>
nn g5 :5wincmd w<cr>
nn g6 :6wincmd w<cr>
nn g7 :7wincmd w<cr>

nn <leader>1 :tabnext 1<cr>
nn <leader>2 :tabnext 2<cr>
nn <leader>3 :tabnext 3<cr>
nn <leader>4 :tabnext 4<cr>
nn <leader>5 :tabnext 5<cr>
nn <leader>6 :tabnext 6<cr>
nn <leader>7 :tabnext 7<cr>
nn <leader>8 :tabnext 8<cr>
nn <leader>9 :tabnext 9<cr>

" Stolen from https://github.com/tpope/vim-sensible (press gx on a link O.O)
" Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and
" call :diffupdate.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"
" Keybindings end
"

" Events callbacks
au FileType c,cpp nnoremap <buffer> <leader>pp oprintf("%\n", );<esc>6hi
au FileType c,cpp nnoremap <buffer> <leader>ps oputs("");<esc>2hi
au FileType c,cpp nnoremap <buffer> <leader>pc oputchar('');<esc>2hi
au BufNewFile,BufRead *.prolog setf prolog
au ColorScheme habamax hi Normal ctermbg=NONE

" Load the least weird default theme (in my machine, at least)
syntax on
colorscheme habamax
