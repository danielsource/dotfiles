" base16-vim (https://github.com/chriskempson/base16-vim)
" by Chris Kempson (http://chriskempson.com)
" Eighties scheme by Chris Kempson (http://chriskempson.com)

" #############################
" FILE MODIFIED BY danielsource
" #############################

let s:gui00 = "#2d2d2d"
let s:gui01 = "#393939"
let s:gui02 = "#515151"
let s:gui03 = "#908379"
let s:gui04 = "#a09f93"
let s:gui05 = "#d3d0c8"
let s:gui06 = "#e8e6df"
let s:gui07 = "#f2f0ec"
let s:gui08 = "#f2777a"
let s:gui09 = "#f99157"
let s:gui10 = "#ffcc66"
let s:gui11 = "#99cc99"
let s:gui12 = "#66cccc"
let s:gui13 = "#6699cc"
let s:gui14 = "#cc99cc"
let s:gui15 = "#d27b53"

if has("terminal")
	let g:terminal_ansi_colors = [
	\ "#2d2d2d",
	\ "#d88d6a",
	\ "#99cc99",
	\ "#ffcc66",
	\ "#6699cc",
	\ "#cc99cc",
	\ "#66cccc",
	\ "#d3d0c8",
	\ "#908379",
	\ "#f26c75",
	\ "#99cc99",
	\ "#ffcc66",
	\ "#6699cc",
	\ "#cc99cc",
	\ "#66cccc",
	\ "#ffffff",
	\ ]
endif

" Theme setup
hi clear
syntax reset
let g:colors_name = "eighties"

" Highlighting function
" Optional variable is attributes
fun <sid>hi(group, guifg, guibg, ...)
	let l:attr = get(a:, 1, "")

	if a:guifg != ""
		exec "hi " . a:group . " guifg=" . a:guifg
	endif
	if a:guibg != ""
		exec "hi " . a:group . " guibg=" . a:guibg
	endif
	if l:attr != ""
		exec "hi " . a:group . " gui=" . l:attr . " cterm=" . l:attr
	endif
endfun

" Vim editor colors
call <sid>hi("Normal",        s:gui05, "NONE", "")
call <sid>hi("Bold",          "", "", "bold")
call <sid>hi("Debug",         s:gui08, "", "")
call <sid>hi("Directory",     s:gui13, "", "")
call <sid>hi("Error",         s:gui00, s:gui08, "")
call <sid>hi("ErrorMsg",      s:gui08, "NONE", "")
call <sid>hi("Exception",     s:gui08, "", "")
call <sid>hi("FoldColumn",    s:gui12, s:gui01, "")
call <sid>hi("Folded",        s:gui03, s:gui01, "")
call <sid>hi("IncSearch",     s:gui01, s:gui09, "none")
call <sid>hi("Italic",        "", "", "none")
call <sid>hi("Macro",         s:gui08, "", "")
call <sid>hi("MatchParen",    "", s:gui03, "")
call <sid>hi("ModeMsg",       s:gui11, "", "")
call <sid>hi("MoreMsg",       s:gui11, "", "")
call <sid>hi("Question",      s:gui13, "", "")
call <sid>hi("Search",        s:gui01, s:gui10, "")
call <sid>hi("Substitute",    s:gui01, s:gui10, "none")
call <sid>hi("SpecialKey",    s:gui03, "", "")
call <sid>hi("TooLong",       s:gui08, "", "")
call <sid>hi("Underlined",    s:gui08, "", "")
call <sid>hi("Visual",        "", s:gui02, "")
call <sid>hi("VisualNOS",     s:gui08, "", "")
call <sid>hi("WarningMsg",    s:gui08, "", "")
call <sid>hi("WildMenu",      s:gui01, s:gui10, "")
call <sid>hi("Title",         s:gui13, "", "none")
call <sid>hi("Conceal",       s:gui13, "NONE", "")
call <sid>hi("Cursor",        s:gui00, s:gui05, "")
call <sid>hi("NonText",       s:gui03, "", "")
call <sid>hi("LineNr",        s:gui03, s:gui01, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, "")
call <sid>hi("StatusLine",    s:gui04, s:gui02, "none")
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, "none")
call <sid>hi("StatusLineTerm",   s:gui04, s:gui02, "none")
call <sid>hi("StatusLineTermNC", s:gui03, s:gui01, "none")
call <sid>hi("VertSplit",     s:gui02, s:gui02, "none")
call <sid>hi("ColorColumn",   "", s:gui01, "none")
call <sid>hi("CursorColumn",  "", s:gui01, "none")
call <sid>hi("CursorLine",    "", s:gui01, "none")
call <sid>hi("CursorLineNr",  s:gui04, s:gui01, "")
call <sid>hi("QuickFixLine",  "", s:gui01, "none")
call <sid>hi("PMenu",         s:gui05, s:gui01, "none")
call <sid>hi("PMenuSel",      s:gui01, s:gui05, "")
call <sid>hi("TabLine",       s:gui03, s:gui01, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, "none")
call <sid>hi("TabLineSel",    s:gui11, s:gui01, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui09, "", "")
call <sid>hi("Character",    s:gui08, "", "")
call <sid>hi("Comment",      s:gui03, "", "italic")
call <sid>hi("Conditional",  s:gui14, "", "")
call <sid>hi("Constant",     s:gui09, "", "")
call <sid>hi("Define",       s:gui14, "", "none")
call <sid>hi("Delimiter",    s:gui15, "", "")
call <sid>hi("Float",        s:gui09, "", "")
call <sid>hi("Function",     s:gui13, "", "")
call <sid>hi("Identifier",   s:gui08, "", "none")
call <sid>hi("Include",      s:gui13, "", "")
call <sid>hi("Keyword",      s:gui14, "", "")
call <sid>hi("Label",        s:gui10, "", "")
call <sid>hi("Number",       s:gui09, "", "")
call <sid>hi("Operator",     s:gui05, "", "none")
call <sid>hi("PreProc",      s:gui10, "", "")
call <sid>hi("Repeat",       s:gui10, "", "")
call <sid>hi("Special",      s:gui12, "", "")
call <sid>hi("SpecialChar",  s:gui15, "", "")
call <sid>hi("Statement",    s:gui08, "", "")
call <sid>hi("StorageClass", s:gui10, "", "")
call <sid>hi("String",       s:gui11, "", "")
call <sid>hi("Structure",    s:gui14, "", "")
call <sid>hi("Tag",          s:gui10, "", "")
call <sid>hi("Todo",         s:gui10, s:gui01, "bold")
call <sid>hi("Type",         s:gui10, "", "none")
call <sid>hi("Typedef",      s:gui10, "", "")

" C highlighting
call <sid>hi("cOperator",   s:gui12, "", "")
call <sid>hi("cPreCondit",  s:gui14, "", "")

" C# highlighting
call <sid>hi("csClass",                 s:gui10, "", "")
call <sid>hi("csAttribute",             s:gui10, "", "")
call <sid>hi("csModifier",              s:gui14, "", "")
call <sid>hi("csType",                  s:gui08, "", "")
call <sid>hi("csUnspecifiedStatement",  s:gui13, "", "")
call <sid>hi("csContextualStatement",   s:gui14, "", "")
call <sid>hi("csNewDecleration",        s:gui08, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", "")
call <sid>hi("cssClassName",   s:gui14, "", "")
call <sid>hi("cssColor",       s:gui12, "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui11, s:gui01, "")
call <sid>hi("DiffChange",   s:gui03, s:gui01, "")
call <sid>hi("DiffDelete",   s:gui08, s:gui01, "")
call <sid>hi("DiffText",     s:gui13, s:gui01, "")
call <sid>hi("DiffAdded",    s:gui11, "NONE", "")
call <sid>hi("DiffFile",     s:gui08, "NONE", "")
call <sid>hi("DiffNewFile",  s:gui11, "NONE", "")
call <sid>hi("DiffLine",     s:gui13, "NONE", "")
call <sid>hi("DiffRemoved",  s:gui08, "NONE", "")

" Git highlighting
call <sid>hi("gitcommitOverflow",       s:gui08, "", "")
call <sid>hi("gitcommitSummary",        s:gui11, "", "")
call <sid>hi("gitcommitComment",        s:gui03, "", "")
call <sid>hi("gitcommitUntracked",      s:gui03, "", "")
call <sid>hi("gitcommitDiscarded",      s:gui03, "", "")
call <sid>hi("gitcommitSelected",       s:gui03, "", "")
call <sid>hi("gitcommitHeader",         s:gui14, "", "")
call <sid>hi("gitcommitSelectedType",   s:gui13, "", "")
call <sid>hi("gitcommitUnmergedType",   s:gui13, "", "")
call <sid>hi("gitcommitDiscardedType",  s:gui13, "", "")
call <sid>hi("gitcommitBranch",         s:gui09, "", "bold")
call <sid>hi("gitcommitUntrackedFile",  s:gui10, "", "")
call <sid>hi("gitcommitUnmergedFile",   s:gui08, "", "bold")
call <sid>hi("gitcommitDiscardedFile",  s:gui08, "", "bold")
call <sid>hi("gitcommitSelectedFile",   s:gui11, "", "bold")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui11, s:gui01, "")
call <sid>hi("GitGutterChange",  s:gui13, s:gui01, "")
call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, "")
call <sid>hi("GitGutterChangeDelete",  s:gui14, s:gui01, "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui10, "", "")
call <sid>hi("htmlItalic",  s:gui14, "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", "")
call <sid>hi("htmlTag",     s:gui05, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", "")
call <sid>hi("javaScriptNumber",  s:gui09, "", "")
" pangloss/vim-javascript highlighting
call <sid>hi("jsOperator",          s:gui13, "", "")
call <sid>hi("jsStatement",         s:gui14, "", "")
call <sid>hi("jsReturn",            s:gui14, "", "")
call <sid>hi("jsThis",              s:gui08, "", "")
call <sid>hi("jsClassDefinition",   s:gui10, "", "")
call <sid>hi("jsFunction",          s:gui14, "", "")
call <sid>hi("jsFuncName",          s:gui13, "", "")
call <sid>hi("jsFuncCall",          s:gui13, "", "")
call <sid>hi("jsClassFuncName",     s:gui13, "", "")
call <sid>hi("jsClassMethodType",   s:gui14, "", "")
call <sid>hi("jsRegexpString",      s:gui12, "", "")
call <sid>hi("jsGlobalObjects",     s:gui10, "", "")
call <sid>hi("jsGlobalNodeObjects", s:gui10, "", "")
call <sid>hi("jsExceptions",        s:gui10, "", "")
call <sid>hi("jsBuiltins",          s:gui10, "", "")

" Mail highlighting
call <sid>hi("mailQuoted1",  s:gui10, "", "")
call <sid>hi("mailQuoted2",  s:gui11, "", "")
call <sid>hi("mailQuoted3",  s:gui14, "", "")
call <sid>hi("mailQuoted4",  s:gui12, "", "")
call <sid>hi("mailQuoted5",  s:gui13, "", "")
call <sid>hi("mailQuoted6",  s:gui10, "", "")
call <sid>hi("mailURL",      s:gui13, "", "")
call <sid>hi("mailEmail",    s:gui13, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui11, "", "")
call <sid>hi("markdownError",             s:gui05, "NONE", "")
call <sid>hi("markdownCodeBlock",         s:gui11, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui13, "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui13, "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", "")
call <sid>hi("phpComparison",      s:gui05, "", "")
call <sid>hi("phpParent",          s:gui05, "", "")
call <sid>hi("phpMethodsVar",      s:gui12, "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui14, "", "")
call <sid>hi("pythonRepeat",    s:gui14, "", "")
call <sid>hi("pythonInclude",   s:gui14, "", "")
call <sid>hi("pythonStatement", s:gui14, "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui13, "", "")
call <sid>hi("rubyConstant",                s:gui10, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui15, "", "")
call <sid>hi("rubyRegexp",                  s:gui12, "", "")
call <sid>hi("rubySymbol",                  s:gui11, "", "")
call <sid>hi("rubyStringDelimiter",         s:gui11, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", "")
call <sid>hi("sassInclude",    s:gui14, "", "")
call <sid>hi("sassMixing",     s:gui14, "", "")
call <sid>hi("sassMixinName",  s:gui13, "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui11, s:gui01, "")
call <sid>hi("SignifySignChange",  s:gui13, s:gui01, "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, "")

" Spelling highlighting
call <sid>hi("SpellBad",     s:gui01, s:gui14, "")
call <sid>hi("SpellLocal",   s:gui01, s:gui13, "")
call <sid>hi("SpellCap",     s:gui01, s:gui13, "")
call <sid>hi("SpellRare",    s:gui01, s:gui13, "")

" Startify highlighting
call <sid>hi("StartifyBracket",  s:gui03, "", "")
call <sid>hi("StartifyFile",     s:gui07, "", "")
call <sid>hi("StartifyFooter",   s:gui03, "", "")
call <sid>hi("StartifyHeader",   s:gui11, "", "")
call <sid>hi("StartifyNumber",   s:gui09, "", "")
call <sid>hi("StartifyPath",     s:gui03, "", "")
call <sid>hi("StartifySection",  s:gui14, "", "")
call <sid>hi("StartifySelect",   s:gui12, "", "")
call <sid>hi("StartifySlash",    s:gui03, "", "")
call <sid>hi("StartifySpecial",  s:gui03, "", "")

" Java highlighting
call <sid>hi("javaOperator",     s:gui13, "", "")

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03 s:gui04 s:gui05 s:gui06 s:gui07 s:gui08 s:gui09 s:gui10 s:gui11 s:gui12 s:gui13 s:gui14 s:gui15
