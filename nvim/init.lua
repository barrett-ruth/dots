vim.cmd [[
    syntax on
    filetype plugin indent on
    let g:mapleader = ' '
    let g:format_fts = [ 'bash', 'javascript', 'javascriptreact', 'lua', 'python', 'sh', 'typescript', 'typescriptreact', 'vim', 'zsh' ]
    ru! ftdetect/*.vim
]]

require 'map'
require 'plug'
require 'lsp'

-- Available leader mappings:
-- egjkmnoux
-- ABDEGHIJKMNORIVX
