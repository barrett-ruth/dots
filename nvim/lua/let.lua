vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_background = 'hard'
vim.g.loaded_textobj_variable_segment = 1

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
    'rrhelper',
    'matchit',
}

for _, plugin in pairs(disabled_builtins) do
    vim.g['loaded_' .. plugin] = 1
end
