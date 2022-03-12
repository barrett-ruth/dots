vim.cmd [[
    syntax on
    filetype plugin indent on
    let g:mapleader = ' '
    ru! ftdetect/*.vim
]]

require 'map'
require 'plug'
require 'lsp'

-- Available leader mappings:
-- aimnoux AEIMNORTUVX
