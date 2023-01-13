vim.g.mapleader = ' '

require 'impatient'

require 'map'
require 'aug'
require 'plugins'
require 'snippets'
require 'lsp'

require('Comment').setup {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
require('lines').setup()
require('run').setup()
require('import-cost').setup()
require('live-server').setup()
require('emmet').setup { keymap = '<c-e>' }
require('nvim-autopairs').setup {}

vim.cmd.colorscheme 'gruvbox'
