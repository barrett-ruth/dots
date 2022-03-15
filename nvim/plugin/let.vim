let g:indent_blankline_show_first_indent_level = v:false

let g:gruvbox_material_better_performance = 1
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
