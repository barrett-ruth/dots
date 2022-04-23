colo gruvbox-material

sign define DiagnosticSignError text=> texthl=RedSign
sign define DiagnosticSignWarn text=- texthl=YellowSign
sign define DiagnosticSignHint text=* texthl=AquaSign
sign define DiagnosticSignInfo text=: texthl=BlueSign

sign define GitSignsChangedelete text=~
sign define GitSignsTopdelete text=‾
sign define GitSignsDelete text=_
sign define GitSignsChange text=│
sign define GitSignsAdd text=│

hi! TelescopeSelection guibg=#45403d
for e in [ 'CursorLineNr', 'SignColumn', 'FoldColumn' ]
    exe 'hi!' e 'ctermbg=NONE' 'guibg=NONE' 'gui=NONE'
endfo

for e in [ 'Normal', 'Error', 'Warning', 'Hint', 'Info' ]
     exe 'hi!' e .. 'Float' 'ctermbg=NONE guibg=NONE gui=NONE'
endfo
for e in [ 'Green', 'Red', 'Yellow', 'Blue', 'Aqua' ]
    exe 'hi!' e .. 'Sign' 'ctermbg=NONE guibg=NONE gui=NONE'
endfo
