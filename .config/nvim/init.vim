colorscheme apprentice

" General settings {{{

set aw
set cino=(0,:0,c0,t0,u0,U0,g0
set clipboard+=unnamedplus mouse=a
set fdm=marker
set grepprg=grep\ --exclude-dir=.git\ --exclude=tags\ -IRsnH
set ic scs
set nu rnu
set path+=**
set sb spr
set spl=en_us,pt_br
set tags+=.user/tags,$VIMRUNTIME/doc/tags
set title
set titlestring=%f
set ts=8 sw=4 sts=4 et
set tw=72 bri sbr========> nowrap
set udf
set wig=*.o,*.out,*.exe,*.bin

let $BASH_ENV = "~/.bash_aliases"
let g:mapleader = " "
let g:netrw_banner = 0

" }}}

" Commands and functions {{{

com! FormatParagraph :call RunNormalRestView("gqap")
com! Indent          :call RunNormalRestView("gg=G")
com! MakeTags        !mkdir -p .user && ctags -f ./.user/tags &
com! SortParagraph   :call RunNormalRestView("vip:sort\<CR>")
com! WrapLines       :call RunNormalRestView("ggVG:norm gqq\<CR>")

fu! RunNormalRestView(arg) abort
    let l:view = winsaveview()
    keepp silent exe "normal " . a:arg
    call winrestview(l:view)
endfunction

fu! TrimTrailingWhitespace() abort
    let l:view = winsaveview()
    keepp %s/\m\s\+$//e
    call winrestview(l:view)
endfunction

" }}}

" Mappings {{{

ino <silent> <C-q> <ESC><C-w>qa
ino <silent> <C-s> <ESC>:update<CR>a
nn <Leader><backspace> :cc<space>
nn <Leader>d :let @+ = expand("%:p:h")<CR>
nn <Leader>f :let @+ = expand("%:p")<CR>
nn <Leader>g :grep<space>
nn <Leader>t :MakeTags<CR>
nn <silent> <C-n> "_
nn <silent> <C-p> :FZF<CR>
nn <silent> <C-q> <C-w>q
nn <silent> <C-s> :update<CR>
nn <silent> <Leader><C-p> :FZF ~<CR>
nn <silent> <Leader><CR> :cl<CR>
nn <silent> <Leader>= :Indent<CR>
nn <silent> <Leader>[ :cp<CR>
nn <silent> <Leader>] :cn<CR>
nn <silent> <Leader>l :set wrap!<CR>
nn <silent> <Leader>m :make<space><up><CR>
nn <silent> <Leader>n :setl nu! rnu!<CR>
nn <silent> <Leader>q :FormatParagraph<CR>
nn <silent> <Leader>r :so $MYVIMRC \| echom 'init.vim re-sourced!'<CR>
nn <silent> <Leader>s :SortParagraph<CR>
nn <silent> <Leader>w :WrapLines<CR>
nn <silent> <Leader>ç :set spell!<CR>
nn <silent> <M-h> <C-w>h
nn <silent> <M-j> <C-w>j
nn <silent> <M-k> <C-w>k
nn <silent> <M-l> <C-w>l
vn <silent> . :norm .<CR>
vn <silent> <C-n> "_
vn <silent> <Leader>s :sor<CR>

" }}}

" Autocommands {{{

au BufEnter    *.c          nn <buffer> <silent> <Leader>a :e %<.h<CR>
au BufEnter    *.h          nn <buffer> <silent> <Leader>a :e %<.c<CR>
au BufEnter    *.h          setl ft=c
au BufEnter    Makefile     nn <buffer> <silent> <Leader>a :e %:p:h/config.mk<CR>
au BufEnter    config.mk    nn <buffer> <silent> <Leader>a :e %:p:h/Makefile<CR>
au BufWritePre *\(.md\)\@<! call TrimTrailingWhitespace()
au FileType    *            setl fo-=t fo-=c fo-=r fo-=o
au FileType    gitconfig    setl noet sw=0 sts=0

" }}}
