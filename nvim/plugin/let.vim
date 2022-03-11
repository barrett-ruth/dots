let g:netrw_bufsettings = [ 'noma', 'nomod', 'nu', 'nobl', 'nowrap', 'rnu', 'ro' ]
let g:netrw_menu = 0
let g:netrw_preview = 1
let g:netrw_banner = 0
let g:netrw_hide = 1
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_browse_split = 3

let g:neoformat_python_black = {
            \ 'exe': 'black',
            \ 'args': [ '-s 4', '-q', '--skip-string-normalization' ]
            \}
