local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

for key, command in pairs {
    a = 'Add',
    c = 'Copy',
    k = 'Mkdir',
    K = 'Rmdir',
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

vim.cmd [[command -nargs=? -complete=file Add lua require('paqs.eunuch').add('<args>')]]
vim.cmd [[command -nargs=? -complete=file Rmdir lua require('paqs.eunuch').rmdir('<args>')]]

return {
    add = function(file)
        local dir = vim.fn.fnamemodify(file, ':h')
        vim.cmd('sil Mkdir ' .. dir)
        vim.cmd('sil !touch ' .. file)
        vim.cmd('e ' .. file)
    end,
    rmdir = function(dir)
        if require('utils').empty(dir) then
            vim.cmd 'Delete'
        else
            vim.cmd('sil !rmdir ' .. dir)
        end
    end,
}
