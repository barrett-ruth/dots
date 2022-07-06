local files = {
    'eunuch',
    'paq',
    'luasnippets',
    'fzf',
    'gitsigns',
    'harpoon',
    'navic',
    'treesitter',
}

for _, v in ipairs(files) do
    require('paqs.' .. v)
end

require('bufdel').setup { next = 'alternate' }
require('Comment').setup { mappings = { extra = true } }
require('spellsitter').setup {}
