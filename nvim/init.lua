require 'let'
require 'map'
require 'aug'

vim.opt.rtp:prepend(vim.fn.stdpath 'data' .. '/lazy/lazy.nvim')

require('lazy').setup('plugins', {
    git = {
        url_format = 'git@github.com:%s.git',
    },
    install = {
        colorscheme = { 'gruvbox' },
    },
    ui = {
        border = 'rounded',
    },
})

require('lines').setup()
require('run').setup()

vim.cmd.colorscheme 'gruvbox'
