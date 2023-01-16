require 'let'
require 'map'
require 'aug'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        'git@github.com:folke/lazy.nvim.git',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    git = {
        url_format = 'git@github.com:%s.git',
    },
    install = {
        colorscheme = { 'gruvbox' },
    },
    lockfile = vim.fn.stdpath 'data' .. '/lazy-lock.json',
    ui = {
        border = 'rounded',
    },
})

require('lines').setup()
require('run').setup()

vim.cmd.colorscheme 'gruvbox'
