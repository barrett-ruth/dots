require 'impatient'

local files = {
    'paq',
    'luasnip',
    'cmp',
    'fugitive',
    'gitsigns',
    'harpoon',
    'lualine',
    'lspkind',
    'telescope',
    'session',
    'treesitter',
}

for _, v in ipairs(files) do
    require('plug/' .. v)
end
