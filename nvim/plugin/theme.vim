colo gruvbox8_hard

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

cal s:Nohl([ 'CursorLineNr' ])
cal s:Nohl_prefix([ 'Add', 'Delete', 'ChangeDelete', 'Change' ], 'GitGutter')
cal s:Nohl_prefix([ 'Change', 'Add', 'Delete', 'Text' ], 'Diff')
cal s:Nohl_suffix([ 'Sign', 'Fold' ], 'Column')

hi! DiffChange guifg=#fabd2f
hi! diffChanged guifg=#fabd2f
hi! QuickFixLine guifg=#fabd2f
hi! DiagnosticInfo guifg=LightBlue
hi! DiagnosticUnderlineInfo cterm=NONE guisp=LightBlue gui=undercurl
hi! DiagnosticError guifg=#fb4934
hi! DiagnosticHint guifg=#a7c080
hi! DiagnosticUnderlineError cterm=NONE guisp=#fb4943 gui=undercurl
hi! DiagnosticSignHint guifg=#a7c080
hi! DiagnosticUnderlineHint guisp=#a7c080 cterm=NONE gui=undercurl
hi! DiagnosticUnderlineWarn cterm=NONE gui=undercurl
