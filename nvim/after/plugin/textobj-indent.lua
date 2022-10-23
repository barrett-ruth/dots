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
