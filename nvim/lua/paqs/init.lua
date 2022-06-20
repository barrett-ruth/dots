local files = {
    'paq',
    'cmp',
    'luasnippets',
    'fzf',
    'gitsigns',
    'harpoon',
    'lualine',
    'navic',
    'treesitter',
}

for _, v in ipairs(files) do
    require('paqs.' .. v)
end

require('bufdel').setup { next = 'alternate' }
require('Comment').setup { mappings = { extra = true } }
require('spellsitter').setup {}
