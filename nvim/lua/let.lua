vim.g.markdown_fenced_languages = {
    'c',
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'lua',
    'python',
    'sql',
    'typescript',
    'typescriptreact',
    'vim',
    'yaml',
}

vim.g.mapleader = ' '

vim.g.python3_host_prog = vim.env.XDG_CONFIG_HOME .. '/nvim/venv/bin/python'

vim.g.matchup_matchparen_offscreen = {}
vim.g.c_syntax_for_h = 1

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
