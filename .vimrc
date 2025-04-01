set nocompatible
set sts=4 sw=4 et ai
set number
set wrap linebreak
set splitright splitbelow
set laststatus=1
set wildmenu
set clipboard^=unnamed,unnamedplus
let g:netrw_banner=0
let loaded_matchparen=1

syntax on
if has('termguicolors')
    set termguicolors
    colorscheme habamax
endif
