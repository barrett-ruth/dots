se bg=dark tgc
" colo gruvbox-material
colo gruvbox

sign define DiagnosticSignError text=> texthl=DiagnosticError
sign define DiagnosticSignWarn text=— texthl=DiagnosticWarn
sign define DiagnosticSignHint text=* texthl=DiagnosticHint
sign define DiagnosticSignInfo text=: texthl=DiagnosticInfo

" hi DiagnosticUnderlineError guisp=#b65c60
" hi DiagnosticUnderlineWarn guisp=#ebc06d
" hi DiagnosticUnderlineHint guisp=#99d59d
" hi DiagnosticUnderlineInfo guisp=#9aacce
"
" for e in [ 'SpellBad', 'SpellCap', 'SpellLocal', 'SpellRare' ]
"     exe 'hi' e 'guifg=NONE'
" endfo
"
" hi MatchParen gui=NONE guifg=NONE
" hi SpellBad guisp=#ebc06d
" hi NormalFloat guibg=NONE
" hi FloatBorder guibg=NONE
