if index(g:filetypes, &ft) >= 0
    syn match op "\zs&&\ze \|\<and\>" conceal cchar=∧
    syn match op "\zs||\ze \|\<or\>" conceal cchar=∨
    syn match op "<=" conceal cchar=≤
    syn match op ">=" conceal cchar=≥
    syn match op "!=\|\~=" conceal cchar=≠

    syn match ellipse /\.\@<!\.\{3}\.\@!/ conceal cchar=…

    if &ft != 'lua'
        syn match fd /-\@<=-/ conceal cchar=
        syn match sd /--\@=/ conceal cchar=
    end

    if &ft == 'javascript' || &ft == 'javascriptreact' || &ft == 'typescript' || &ft == 'typescriptreact'
        syn match fear /=\@<=>/ conceal cchar=⇒
        syn match sear /=>\@=/ conceal cchar=
    end

    syn match feq /=\@<==/ conceal cchar=
    syn match seq /==\@=/ conceal cchar=
end
