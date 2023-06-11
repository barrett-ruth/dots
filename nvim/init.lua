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

vim.cmd.colorscheme('lite')

vim.g.terminal_color_0 = "#000000"
    vim.g.terminal_color_1 = "#aa3731"
    vim.g.terminal_color_2 = "#448c27"
    vim.g.terminal_color_3 = "#cb9000"
    vim.g.terminal_color_4 = "#325cc0"
    vim.g.terminal_color_5 = "#7a3e9d"
    vim.g.terminal_color_6 = "#0083b2"
    vim.g.terminal_color_7 = "#f7f7f7"
    vim.g.terminal_color_8 = "#777777"
    vim.g.terminal_color_9 = "#f05050"
    vim.g.terminal_color_10 = "#60cb00"
    vim.g.terminal_color_11 = "#ffbc5d"
    vim.g.terminal_color_12 = "#007acc"
    vim.g.terminal_color_13 = "#e64ce6"
    vim.g.terminal_color_14 = "#00aacb"
    vim.g.terminal_color_15 = "#f7f7f7"
