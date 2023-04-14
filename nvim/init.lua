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
    change_detection = {
        enabled = false,
        notify = false,
    },
    git = {
        url_format = 'git@github.com:%s.git',
    },
    lockfile = vim.fn.stdpath 'data' .. 'lazy-lock.json',
})

require('lines').setup()
vim.cmd.colorscheme 'gruvbox'
