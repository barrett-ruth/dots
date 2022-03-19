colo gruvbox-material

hi! TelescopeSelection guibg=#45403d
hi! CursorLineNr ctermbg=NONE guibg=NONE gui=NONE
hi! SignColumn ctermbg=NONE guibg=NONE gui=NONE

for e in [ 'Normal', 'Error', 'Warning', 'Hint', 'Info' ]
     exe 'hi!' e .. 'Float' 'ctermbg=NONE guibg=NONE gui=NONE'
endfo
for e in [ 'Green', 'Red', 'Yellow', 'Blue', 'Aqua' ]
    exe 'hi!' e .. 'Sign' 'ctermbg=NONE guibg=NONE gui=NONE'
endfo
