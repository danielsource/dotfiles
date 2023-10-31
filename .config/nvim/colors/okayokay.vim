set notermguicolors
hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name = "okayokay"

" UI

hi Error                cterm=NONE    ctermfg=15   ctermbg=1
hi NonText              cterm=NONE    ctermfg=8    ctermbg=NONE
hi StatusLine           cterm=NONE    ctermfg=0    ctermbg=7
hi StatusLineNC         cterm=NONE    ctermfg=15   ctermbg=8
hi VertSplit            cterm=NONE    ctermfg=0    ctermbg=NONE
hi Search               cterm=reverse ctermfg=11   ctermbg=0
hi clear MatchParen
hi clear Title

if &background == 'light'
	hi TabLine      cterm=NONE    ctermfg=0    ctermbg=NONE
	hi CursorLineNr cterm=bold    ctermfg=8    ctermbg=7
	hi StatusLine   cterm=NONE    ctermfg=15   ctermbg=0
	hi StatusLineNC cterm=NONE    ctermfg=7    ctermbg=8
else
	hi TabLine      cterm=NONE    ctermfg=7    ctermbg=NONE
	hi CursorLineNr cterm=bold    ctermfg=7    ctermbg=0
endif

hi! link Pmenu       StatusLineNC
hi! link ColorColumn StatusLineNC
hi! link PmenuSel    StatusLine
hi! link TabLineSel  StatusLine
hi! link TabLineFill TabLine
hi! link LineNr      TabLine

" Syntax

hi Comment      cterm=NONE ctermfg=2
hi Constant     cterm=NONE ctermfg=12
hi PreProc      cterm=bold ctermfg=14
hi Special      cterm=bold ctermfg=NONE
hi Statement    cterm=bold ctermfg=5

hi! link Identifier  Special
hi! link Todo        Special
hi! link Type        Statement

hi! link javaScript  Normal
