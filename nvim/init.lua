vim.cmd [[
    syntax on
    filetype plugin indent on
    let g:mapleader = ' '
    let g:fmt_fts = [ 'bash', 'javascript', 'javascriptreact', 'lua', 'python', 'sh', 'typescript', 'typescriptreact' ]
    ru! ftdetect/*.vim
]]

require 'map'
require 'plug'
require 'lsp'

-- Available leader mappings:
-- ejmnux
-- ADEGHIJKMNORIVX
