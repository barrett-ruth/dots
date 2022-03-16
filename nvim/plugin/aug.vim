aug augs
    au!
    au BufEnter * setl fo-=cro
    au TextYankPost * sil! lua vim.highlight.on_yank { higroup = 'RedrawDebugNormal', timeout = '700' }
    au BufWritePre * lua require 'utils'.format()
aug end
