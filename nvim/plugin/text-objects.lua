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

vim.g.loaded_textobj_comment = 1
vim.fn['textobj#user#plugin']('comment', {
    ['-'] = {
        ['select-a'] = 'a/',
        ['select-a-function'] = 'textobj#comment#select_a',
        ['select-i'] = 'i/',
        ['select-i-function'] = 'textobj#comment#select_i',
    },
})
