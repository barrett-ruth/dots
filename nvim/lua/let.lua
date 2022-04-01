vim.g.indent_blankline_filetype_exclude = { '', 'aerial', 'checkhealth', 'help', 'lspinfo', 'man' }
vim.g.indent_blankline_show_first_indent_level = false

vim.g.gruvbox_material_better_performance = 1

local disabled_built_ins = {
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

for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end
