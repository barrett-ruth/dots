require('git-worktree').setup {}

local utils = require 'utils'
local map = utils.map

map({
    'n',
    '\\wa',
    [[:lua require('git-worktree').create_worktree(unpack(vim.split('', ' ')))<left><left><left><left><left><left><left><left><left>]],
}, {
    silent = false,
})
map({ 'n', '\\ws', [[:lua require('git-worktree').switch_worktree('')<left><left>]] }, {
    silent = false,
})
map({ 'n', '\\wd', [[:lua require('git-worktree').delete_worktree('')<left><left>]] }, {
    silent = false,
})
