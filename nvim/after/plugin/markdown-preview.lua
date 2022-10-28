local g = vim.g

g.mkdp_auto_close = 0
g.mkdp_theme = 'dark'
g.mkdp_refresh_slow = 1
g.mkdp_page_title = '${name}'
vim.cmd [[
fun OpenMarkdownPreview(url)
    exec 'sil !chromium --new-window ' . a:url
endf
]]
g.mkdp_browserfunc = 'OpenMarkdownPreview'
