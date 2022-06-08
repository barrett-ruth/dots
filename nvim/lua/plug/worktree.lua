require('git-worktree').setup {}

local utils = require 'utils'
local bmap = utils.bmap

bmap(
    {
        'n',
        '\\wa',
        ":lua require('git-worktree').create_worktree(unpack(vim.split('', ' ')))<left><left><left><left><left><left><left><left><left>",
    },
    {
        silent = false,
    }
)
bmap({ 'n', '\\ws', ":lua require('git-worktree').switch_worktree('')<left><left>" }, {
    silent = false,
})
bmap({ 'n', '\\wd', ":lua require('git-worktree').delete_worktree('')<left><left>" }, {
    silent = false,
})
