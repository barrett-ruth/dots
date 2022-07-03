vim.g.matchup_matchparen_offscreen = {}
vim.g.did_load_filetypes = 1

local disabled_builtins = {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'tutor_mode_plugin',
    'rrhelper',
    'matchit',
}

for _, plugin in pairs(disabled_builtins) do
    vim.g['loaded_' .. plugin] = 1
end
