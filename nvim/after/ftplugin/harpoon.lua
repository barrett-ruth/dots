local utils = require 'utils'

utils.bmap {
    'n',
    'v',
    function()
        local line = vim.api.nvim_get_current_line()
        local pwd = vim.fn.getcwd() .. '/'
        local path = pwd .. line

        vim.cmd('vs ' .. path)
    end,
}
