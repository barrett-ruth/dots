vim.g.loaded_textobj_indent = 1
vim.fn['textobj#user#plugin']('indent', {
    same = {
        ['select-a'] = 'a=',
        ['*select-a-function*'] = 'textobj#indent#select_same_a',
        ['select-i'] = 'i=',
        ['*select-i-function*'] = 'textobj#indent#select_same_i',
    },
})
