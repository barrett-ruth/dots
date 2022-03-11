aug augs
    au! BufEnter * setl fo-=cro
    au! BufWritePre * try | undoj | sil Neoformat | cat /E790/ | sil Neoformat | endt
aug end

