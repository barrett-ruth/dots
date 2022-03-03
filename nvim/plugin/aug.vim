aug augs
    au! BufEnter * setl fo-=cro
    au! BufWritePre * try | undoj | Neoformat | cat /E790/ | Neoformat | endt
aug end

