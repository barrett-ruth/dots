let g:loaded_textobj_variable_segment = 1
cal textobj#user#plugin('variable', {
    \ '-': {
    \     'sfile': expand('<sfile>:p'),
    \     'select-a': 'as',  'select-a-function': 'textobj#variable_segment#select_a',
    \     'select-i': 'is',  'select-i-function': 'textobj#variable_segment#select_i',
    \ }})
