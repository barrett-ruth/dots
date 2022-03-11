colo gruvbox-material

fun! s:Hlstr(group)
    exe 'hi!' a:group 'ctermbg=NONE guibg=NONE gui=NONE'
endfun

fun! s:Nohl(groups)
    for group in a:groups
        cal s:Hlstr(group)
    endfo
endfun

fun! s:Nohl_suffix(groups, suffix)
    for group in a:groups
        cal s:Hlstr(group .. a:suffix)
    endfo
endfun

fun! s:Nohl_prefix(groups, prefix)
    for group in a:groups
        cal s:Hlstr(a:prefix .. group)
    endfo
endfun

cal s:Nohl([ 'CursorLineNr', 'SignColumn' ])
cal s:Nohl_prefix([ 'Change', 'Add', 'Delete', 'Text' ], 'Diff')
cal s:Nohl_suffix([ 'Error', 'Warning', 'Hint', 'Info' ], 'Float')
cal s:Nohl_suffix([ 'Green', 'Red', 'Yellow', 'Blue', 'Aqua' ], 'Sign')

hi! TelescopeSelection guibg=#45403d
