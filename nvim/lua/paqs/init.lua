local files = {
    'paq',
    'cmp',
    'luasnippets',
    'fzf',
    'gitsigns',
    'harpoon',
    'treesitter',
}

for _, v in ipairs(files) do
    require('paqs.' .. v)
end

require('bufdel').setup { next = 'alternate' }
require('Comment').setup { mappings = { extra = true } }
require('nvim-navic').setup { depth_limit = 4 }
require('spellsitter').setup {}
