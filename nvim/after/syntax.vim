if index(g:filetypes, &ft) >= 0
    syn match op "\<&&\>\|\<and\>" conceal cchar=∧
    syn match op "\<||\>\|\<or\>" conceal cchar=∨
    syn match op "<=" conceal cchar=≤
    syn match op ">=" conceal cchar=≥
    syn match op "!=\|\~=" conceal cchar=≠

    syn match dots /\%(\.\)\@<!\.\{2}\%(\.\)\@!/ conceal cchar=‥
    syn match ellipse /\%(\.\)\@<!\.\{3}\%(\.\)\@!/ conceal cchar=…

    syn match fd /-\@<=-/ conceal cchar=
    syn match sd /-\(-\)\@=/ conceal cchar=

    syn match fear /=\@<=>/ conceal cchar=⇒
    syn match sear /=\(>\)\@=/ conceal cchar=

    syn match fsar /-\@<=>/ conceal cchar=→
    syn match sear /-\(>\)\@=/ conceal cchar=

    syn match feq / \zs=\ze=/ conceal cchar=
    syn match seq / \@<!=/ conceal cchar=
end
