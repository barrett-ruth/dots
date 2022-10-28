local env, g = vim.env, vim.g

g.markdown_fenced_languages = {
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

g.mapleader = ' '

if env.XDG_CONFIG_HOME == nil then
    env.XDG_CONFIG_HOME = env.HOME .. '/.config'
end

if env.XDG_DATA_HOME == nil then
    env.XDG_DATA_HOME = env.HOME .. '/.local/share'
end

g.python3_host_prog = env.XDG_CONFIG_HOME .. '/nvim/venv/bin/python'

g.matchup_matchparen_offscreen = {}
g.c_syntax_for_h = 1

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
    g['loaded_' .. plugin] = 1
end

local utils = require 'utils'

utils.map { 'n', 'gx', utils.open_url }
