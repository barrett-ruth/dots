require('let')
require('map')
require('filetype')
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
    git = { url_format = 'git@github.com:%s.git' },
    change_detection = { enabled = false },
})

-- vim.cmd.colorscheme(vim.env.THEME)
vim.o.background = 'dark'

vim.tbl_add_reverse_lookup = function(tbl)
    for k, v in pairs(tbl) do
        tbl[v] = k
    end
end
