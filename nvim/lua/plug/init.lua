local files = {
    'paq',
    'comment',
    'luasnippets',
    'fugitive',
    'fzf',
    'gitsigns',
    'harpoon',
    'lualine',
    'treesitter',
    'worktree',
}

for _, v in ipairs(files) do
    require('plug.' .. v)
end
