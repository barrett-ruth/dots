local files = {
    'paq',
    'comment',
    'luasnippets',
    'fzf',
    'gitsigns',
    'harpoon',
    'lualine',
    'treesitter',
}

for _, v in ipairs(files) do
    require('paqs.' .. v)
end
