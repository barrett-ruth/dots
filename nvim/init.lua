vim.g.mapleader = ' '

require 'impatient'

require 'map'
require 'aug'
require 'plugins'
require 'snippets'
require 'lsp'

require('Comment').setup()
require('lines').setup()
require('run').setup()

vim.cmd.colorscheme 'gruvbox'
