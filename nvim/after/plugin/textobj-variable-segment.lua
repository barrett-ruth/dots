local utils = require 'utils'

utils.map({ 'o', 'iS', 'is' }, { noremap = true })
utils.map({ 'o', 'aS', 'as' }, { noremap = true })

vim.g.loaded_textobj_variable_segment = 1
vim.fn['textobj#user#plugin']('variable', {
    ['-'] = {
        sfile = vim.fn.expand '<sfile>:p',
        ['select-a'] = 'as',
        ['select-a-function'] = 'textobj#variable_segment#select_a',
        ['select-i'] = 'is',
        ['select-i-function'] = 'textobj#variable_segment#select_i',
    },
})
