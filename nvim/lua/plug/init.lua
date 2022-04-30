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
    separator = ' -> ',
    icons = { ['container-name'] = ' ', ['class-name'] = 'ﴯ ' },
}

for _, v in ipairs(files) do
    require('plug.' .. v)
end
