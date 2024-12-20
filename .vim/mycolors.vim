syntax on

autocmd! ColorScheme * set bg=dark
autocmd  ColorScheme * hi  Normal ctermbg=NONE
autocmd  ColorScheme * hi  Error term=reverse cterm=reverse ctermfg=167 ctermbg=234
autocmd  ColorScheme * hi  SpellBad term=reverse cterm=underline ctermfg=167
autocmd  ColorScheme * hi  SpellCap term=reverse cterm=underline ctermfg=67
autocmd  ColorScheme * hi  SpellLocal term=reverse cterm=underline ctermfg=108
autocmd  ColorScheme * hi  SpellRare term=reverse cterm=underline ctermfg=182
autocmd  ColorScheme * hi! link ErrorMsg Error
autocmd  ColorScheme * hi! link StatusLineTerm StatusLine
autocmd  ColorScheme * hi! link StatusLineTermNC StatusLineNC

set bg=dark
let g:gruvbox_termcolors = 16
colorscheme process
