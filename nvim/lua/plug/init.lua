require 'impatient'

local files = {
    'paq',
    'aerial',
    'luasnip',
    'cmp',
    'fugitive',
    'gitsigns',
    'harpoon',
    'lualine',
    'lspkind',
    'rooter',
    'telescope',
    'session',
    'treesitter',
}

for _, v in ipairs(files) do
    require('plug/' .. v)
end
