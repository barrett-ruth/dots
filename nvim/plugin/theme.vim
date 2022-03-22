colo gruvbox-material

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
