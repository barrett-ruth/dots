local utils = require 'utils'
local map, mapstr = utils.map, utils.mapstr

map {
    'n',
    '<leader>fe',
    mapstr('fzf-lua', 'files({ cwd = vim.env.XDG_CONFIG_HOME })'),
}
map { 'n', '<c-f>', mapstr 'FzfLua files' }
map { 'n', '<c-g>', mapstr 'FzfLua live_grep_native' }
map {
    'n',
    '<leader>ff',
    mapstr('fzf-lua', [[files { cwd = vim.fn.expand '%:p:h' }]]),
}
map {
    'n',
    '<leader>fg',
    mapstr('fzf-lua', [[live_grep_native { cwd = vim.fn.expand '%:p:h' }]]),
}
map { 'n', '<leader>fh', mapstr 'FzfLua help_tags' }
map { 'n', '<leader>fm', mapstr 'FzfLua man_pages' }
map { 'n', '<leader>fr', mapstr 'FzfLua resume' }
map { 'n', '<leader>fs', mapstr('fzf-lua', 'files { cwd = vim.env.SCRIPTS }') }
