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
    disable_icons = true,
}

for _, v in ipairs(files) do
    require('plug.' .. v)
end
