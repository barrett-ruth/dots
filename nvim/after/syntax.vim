if index(g:filetypes, &ft) >= 0
    syn match op "&&\|\<and\>" conceal cchar=∧
    syn match op "||\|\<or\>" conceal cchar=∨
    syn match op "<=" conceal cchar=≤
    syn match op ">=" conceal cchar=≥
    syn match op "!=\|\~=" conceal cchar=≠

    syn match dots /\.\./ conceal cchar=‥
    syn match ellipse /\zs\.\.\ze\@=\./ conceal cchar=…

    syn match feq / \zs=\ze=/ conceal cchar=
    syn match seq / \@<!=/ conceal cchar=
end
