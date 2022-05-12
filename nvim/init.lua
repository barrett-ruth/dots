vim.cmd [[
    syntax on
    filetype plugin indent on
    let g:mapleader = ' '
    let g:filetypes = [ 'bash', 'c', 'cpp', 'css', 'dockerfile', 'html', 'http', 'java', 'javascript', 'javascriptreact', 'json', 'lua', 'make', 'python', 'typescript', 'typescriptreact', 'vim', 'yaml', 'zsh' ]
]]

require 'impatient'
require 'aug'
require 'let'
require 'map'
require 'plug'
