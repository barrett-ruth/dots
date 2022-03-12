aug augs
    au! BufEnter * setl fo-=cro
    au! BufWritePre * lua require 'utils'.format(vim.bo.ft)
aug end
