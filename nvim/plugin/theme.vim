" let g:gruvbox_material_better_performance = 1 | let g:gruvbox_material_background = 'hard' | colo gruvbox-material
se bg=dark tgc
colo melange

if g:colors_name == 'melange'
    sign define DiagnosticSignError text=> texthl=DiagnosticError
    sign define DiagnosticSignWarn text=— texthl=DiagnosticWarn
    sign define DiagnosticSignHint text=* texthl=DiagnosticHint
    sign define DiagnosticSignInfo text=: texthl=DiagnosticInfo

    hi DiagnosticUnderlineError guisp=#b65c60
    hi DiagnosticUnderlineWarn guisp=#ebc06d
    hi DiagnosticUnderlineHint guisp=#99d59d
    hi DiagnosticUnderlineInfo guisp=#9aacce

    for e in [ 'SpellBad', 'SpellCap', 'SpellLocal', 'SpellRare' ]
        exe 'hi' e 'guifg=NONE'
    endfo

    hi MatchParen gui=NONE guifg=NONE
    hi SpellBad guisp=#ebc06d
else
    sign define DiagnosticSignError text=> texthl=RedSign
    sign define DiagnosticSignWarn text=— texthl=YellowSign
    sign define DiagnosticSignHint text=* texthl=GreenSign
    sign define DiagnosticSignInfo text=: texthl=BlueSign

    let nostr = 'ctermbg=NONE guibg=NONE gui=NONE'

    hi FloatBorder guibg=NONE
    hi MatchWord cterm=NONE gui=NONE
    hi MatchWordCur cterm=NONE gui=NONE
    hi MatchParenCur cterm=NONE gui=NONE
    hi SpellBad guisp=#d8a657

    for e in [ 'SignColumn', 'FoldColumn' ]
        exe 'hi' e nostr
    endfo

    for e in [ 'Normal', 'Error', 'Warning', 'Hint', 'Info' ]
        exe 'hi' e .. 'Float' nostr
    endfo

    for e in [ 'Green', 'Red', 'Yellow', 'Blue', 'Aqua', 'Orange' ]
        exe 'hi' e .. 'Sign' nostr
    endfo
end
