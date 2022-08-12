vim.g.mapleader = ' '

vim.g.livepreview_previewer = 'zathura'

vim.g.matchup_matchparen_offscreen = {}
vim.g.c_syntax_for_h = 1
vim.g.Hexokinase_highlighters = { 'foregroundfull' }
vim.g.Hexokinase_ftEnabled = {
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
vim.g.markdown_fenced_languages = vim.g.Hexokinase_ftEnabled

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
