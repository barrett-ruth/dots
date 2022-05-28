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

for _, v in ipairs(files) do
    require('plug.' .. v)
end
