let s:syntax_filetypes = [ 'c', 'cpp', 'java', 'javascript', 'javascriptreact', 'lua', 'python', 'sh', 'typescript', 'typescriptreact', 'vim', 'zsh' ]

if index(s:syntax_filetypes, &ft) < 0
    setl cole=0
    finish
end

setl cole=1

syn match ellipse /\.\@<!\.\{3}\.\@!/ conceal cchar=…

if &ft != 'lua' && &ft != 'sh' && &ft != 'zsh'
    syn match fd /-\@<=-/ conceal cchar=
    syn match sd /--\@=/ conceal cchar=
elseif &ft == 'sh' || &ft == 'zsh'
    syn match shExpr '||' conceal cchar=∨
    syn match shExpr '&&' conceal cchar=∧
end

let s:js = &ft == 'javascript'
let s:jsx = &ft == 'javascriptreact'

if s:js || s:jsx || &ft == 'typescript' || &ft == 'typescriptreact'
    let s:which = (s:js || s:jsx ? 'java' : 'type') .. 'ScriptOperator'
    exe 'syn match' s:which "'&&' conceal cchar=∧"
    exe 'syn match' s:which "'||' conceal cchar=∨"
    exe 'syn match' s:which "'!=' conceal cchar=≠"
    exe 'syn match' s:which "'>=' conceal cchar=≥"
    exe 'syn match' s:which "'<=' conceal cchar=≤"

    syn match fear /=\@<=>/ conceal cchar=⇒
    syn match sear /=>\@=/ conceal cchar=
end

syn match feq /=\@<==/ conceal cchar=
syn match seq /==\@=/ conceal cchar=
