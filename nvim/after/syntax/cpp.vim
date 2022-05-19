syn match fsar /-\@<=>/ conceal cchar=→
syn match sear /-\(>\)\@=/ conceal cchar=

syn match cppOperator ' \@<=\zs&&\ze\@= ' conceal cchar=∧
syn match cppOperator '||' conceal cchar=∨
syn match cppOperator '!=' conceal cchar=≠
syn match cppOperator '>=' conceal cchar=≥
syn match cppOperator '<=' conceal cchar=≤
syn match cppOperator "\(^\s*for.*\)\@<=:" conceal cchar=∈
syn match cppOperator '<<' conceal cchar=«
syn match cppOperator '>>' conceal cchar=»
