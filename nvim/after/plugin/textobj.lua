vim.g.loaded_textobj_indent = 1
vim.fn['textobj#user#plugin']('indent', {
    ['-'] = {
        ['select-a'] = 'a=',
        ['*select-a-function*'] = 'textobj#indent#select_a',
        ['select-i'] = 'i=',
        ['*select-i-function*'] = 'textobj#indent#select_i',
    },
    same = {
        ['select-a'] = 'aI',
        ['*select-a-function*'] = 'textobj#indent#select_same_a',
        ['select-i'] = 'iI',
        ['*select-i-function*'] = 'textobj#indent#select_same_i',
    },
})

map({ 'o', 'iS', 'is' }, { noremap = true })
map({ 'o', 'aS', 'as' }, { noremap = true })

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
