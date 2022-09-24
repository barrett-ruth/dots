vim.g.loaded_textobj_comment = 1
vim.fn['textobj#user#plugin']('comment', {
    ['-'] = {
        ['select-a'] = 'a/',
        ['select-a-function'] = 'textobj#comment#select_a',
        ['select-i'] = 'i/',
        ['select-i-function'] = 'textobj#comment#select_i',
    },
})
