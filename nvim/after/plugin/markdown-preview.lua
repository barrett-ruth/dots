vim.g.mkdp_auto_close = 0
vim.g.mkdp_theme = 'dark'
vim.g.mkdp_refresh_slow = 1
vim.g.mkdp_page_title = '${name}'
vim.cmd [[
  fun OpenMarkdownPreview(url)
      exec 'sil !chromium --new-window ' . a:url
  endf
]]
vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
