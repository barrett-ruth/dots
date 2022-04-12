local files = {
    'paq',
    'aerial',
    'comment',
    'luasnippets',
    'cmp',
    'fugitive',
    'gitsigns',
    'harpoon',
    'lualine',
    'telescope',
    'session',
    'treesitter',
    'lsp',
}

for _, v in ipairs(files) do
    require('plug/' .. v)
end
