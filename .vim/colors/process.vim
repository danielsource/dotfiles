hi clear
syntax reset

if has('termguicolors')
	set notermguicolors
endif

let g:colors_name = 'process'

hi Normal         ctermfg=7  ctermbg=NONE  ctermul=NONE cterm=NONE
hi NonText        ctermfg=8  ctermbg=NONE  ctermul=NONE cterm=NONE
hi MatchParen     ctermfg=0  ctermbg=5     ctermul=NONE cterm=NONE
hi Directory      ctermfg=4  ctermbg=NONE  ctermul=NONE cterm=NONE
hi SpellBad       ctermfg=1  ctermbg=NONE  ctermul=NONE cterm=underline
hi! link Title Normal
hi! link LineNr NonText
hi! link CursorLineNr LineNr
hi! link Folded NonText
hi! link FoldColumn Folded
hi! link SignColumn NonText
hi! link SpellCap SpellBad
hi! link SpellRare SpellBad
hi! link SpellLocal SpellBad

hi Visual         ctermfg=0  ctermbg=6     ctermul=NONE cterm=NONE
hi! link VisualNOS Visual
hi! link CursorLine Visual

hi IncSearch      ctermfg=0  ctermbg=1     ctermul=NONE cterm=NONE
hi Search         ctermfg=0  ctermbg=3     ctermul=NONE cterm=NONE
hi! link WildMenu Search

hi StatusLine     ctermfg=0  ctermbg=7     ctermul=NONE cterm=NONE
hi StatusLineNC   ctermfg=7  ctermbg=8     ctermul=NONE cterm=NONE
hi! link VertSplit StatusLine
hi! link Pmenu StatusLineNC
hi! link PmenuSbar Pmenu
hi! link PmenuSel StatusLine
hi! link PmenuThumb PmenuSel
hi! link CursorColumn StatusLineNC
hi! link ColorColumn StatusLineNC
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC

hi TabLine        ctermfg=7  ctermbg=NONE  ctermul=NONE cterm=NONE
hi TabLineSel     ctermfg=0  ctermbg=7     ctermul=NONE cterm=NONE
hi! link TabLineFill TabLine
hi! link ToolbarLine TabLineFill
hi! link ToolbarButton TabLineSel

hi ErrorMsg       ctermfg=9  ctermbg=NONE  ctermul=NONE cterm=NONE
hi MoreMsg        ctermfg=2  ctermbg=NONE  ctermul=NONE cterm=NONE
hi! link WarningMsg ErrorMsg
hi! link ModeMsg MoreMsg
hi! link Question MoreMsg

hi DiffAdd        ctermfg=0  ctermbg=2     ctermul=NONE cterm=NONE
hi DiffChange     ctermfg=0  ctermbg=4     ctermul=NONE cterm=NONE
hi DiffText       ctermfg=0  ctermbg=5     ctermul=NONE cterm=NONE
hi! link DiffDelete DiffChange

hi Comment        ctermfg=2  ctermbg=NONE  ctermul=NONE cterm=NONE
hi Constant       ctermfg=4  ctermbg=NONE  ctermul=NONE cterm=NONE
hi Underlined     ctermfg=5  ctermbg=NONE  ctermul=NONE cterm=underline
hi Todo           ctermfg=3  ctermbg=NONE  ctermul=NONE cterm=underline
hi Statement      ctermfg=7  ctermbg=NONE  ctermul=NONE cterm=NONE
hi! link Error Normal
hi! link Identifier Normal
hi! link Delimiter Identifier
hi! link Statement Identifier
hi! link Type Identifier
hi! link SpecialComment Comment
hi! link Special Constant
hi! link SpecialKey Special
hi! link PreProc Identifier
hi! link cPreProc Comment
hi! link cPreCondit cPreProc
hi! link shQuote Constant
hi! link shShellVariables Constant
hi! link javaScriptValue Constant
hi! link sqlSpecial Identifier

hi texStatement cterm=bold
hi! link texCmdName texStatement
hi! link texDef texStatement
hi! link texDelimiter texStatement
hi! link texInputCurlies texStatement
hi! link texMathDelim texStatement
hi! link texNewCmd texStatement
hi! link texNewEnv texStatement
hi! link texRefZone texStatement
hi! link texSection texStatement
hi! link texType texStatement
hi! link texBoldItalStyle Normal
hi! link texBoldStyle Normal
hi! link texCmdArgs Normal
hi! link texDefParm Normal
hi! link texEmphStyle Normal
hi! link texInput Normal
hi! link texInputFile Normal
hi! link texItalBoldStyle Normal
hi! link texItalStyle Normal
hi! link texLength Normal
hi! link texLigature Normal
hi! link texMath Normal
hi! link texMathOper Normal
hi! link texOption Normal
hi! link texSpecialChar Normal
hi! link texString Normal
