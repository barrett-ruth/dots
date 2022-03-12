let g:netrw_bufsettings  = [ 'noma', 'nomod', 'nu', 'nobl', 'nowrap', 'rnu', 'ro' ]
let g:netrw_menu         = 0
let g:netrw_preview      = 1
let g:netrw_banner       = 0
let g:netrw_hide         = 1
let g:netrw_liststyle    = 3
let g:netrw_altv         = 1
let g:netrw_browse_split = 3

let g:gruvbox_material_disable_italic_comment = 1

let g:neoformat_python_black = { 'exe': 'black', 'args': [ '-s 4', '-q', '--skip-string-normalization' ] }

lua << EOF
local disabled_built_ins = {
    'netrw',
    "netrwPlugin",
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'matchit'
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end

EOF
