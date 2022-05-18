local files = {
    'paq',
    'comment',
    'luasnippets',
    'cmp',
    'fugitive',
    'gitsigns',
    'harpoon',
    'lualine',
    'telescope',
    'treesitter',
    'lsp',
}
require('nvim-gps').setup {
    depth = 3,
    depth_limit_indicator = '...',
    separator = ' → ',
    icons = { ['container-name'] = '  ', ['class-name'] = 'ﴯ ' },
}

for _, v in ipairs(files) do
    require('plug.' .. v)
end
