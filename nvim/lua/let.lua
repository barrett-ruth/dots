vim.g.mapleader = ' '

vim.g.mkdp_auto_close = 0
vim.g.mkdp_refresh_slow = 1
vim.g.mkdp_page_title = '${name}'

vim.g.db_ui_icons = {
    expanded = 'v',
    collapsed = '>',
    saved_query = '*',
    new_query = '+',
    tables = '~',
    buffers = '>>',
    connection_ok = '✓',
    connection_error = '✕',
}

vim.g.matchup_matchparen_offscreen = {}
vim.g.c_syntax_for_h = 1
vim.g.markdown_fenced_languages = {
    'c',
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'python',
    'typescript',
    'typescriptreact',
    'vim',
}

local disabled_builtins = {
    'gzip',
    'matchit',
    'matchparen',
    'netrwPlugin',
    'rplugin',
    'spellfile',
    'tarPlugin',
    'tohtml',
    'tutor',
    'zipPlugin',
}

for _, plugin in pairs(disabled_builtins) do
    vim.g['loaded_' .. plugin] = 1
end
