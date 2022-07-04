local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map {
    'n',
    '<leader>el',
    mapstr 'setl nospr'
        .. mapstr '30vs|te tree -aLCF 1 --noreport | tail -n +2'
        .. mapstr 'setl spr',
}
map {
    'n',
    '<leader>etl',
    mapstr 'setl nospr' .. mapstr(
        'utils',
        [[tempcd('30vs|te tree -aLCF 1 --noreport | tail -n +2')]]
    ) .. mapstr 'setl spr',
}

for key, command in pairs {
    a = 'sil !touch',
    c = 'Copy',
    k = 'Mkdir',
    m = 'Move',
    r = 'Rename',
    d = 'sil !rm',
} do
    map({ 'n', '<leader>e' .. key, ':' .. command .. ' ' }, { silent = false })
    map({
        'n',
        '<leader>et' .. key,
        function()
            vim.fn.feedkeys(';' .. command .. ' ' .. vim.fn.expand '%:h' .. '/')
        end,
    }, { silent = false })
end

map({ 'n', '<leader>eD', mapstr 'Delete!' }, { silent = false })
