require('let')
require('map')
require('aug')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        'git@github.com:folke/lazy.nvim.git',
        lazypath,
    })
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
    lockfile = vim.fn.stdpath('data') .. 'lazy-lock.json',
    performance = {
        rtp = {
            disabled_plugins = {
                'getscriptPlugin',
                'gzip',
                'logiPat',
                'netrwPlugin',
                'rplugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})

require('lines').setup()
require('projects').setup()

vim.cmd.colorscheme('light')
