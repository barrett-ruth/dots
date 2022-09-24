require 'paqs.paq'
require 'paqs.luasnippets'

require('bufdel').setup { next = 'alternate' }
require('Comment').setup { mappings = { extra = true } }
require('neoclip').setup { keys = { fzf = { opts = { prompt = 'clip> ' } } } }
require('run').setup()
