local utils = require 'utils'
local mapstr = utils.mapstr
local map = utils.map

local vcsleader = '<leader>v'

-- Fugitive
map { 'n', vcsleader .. 'd', mapstr 'G d' }
map { 'n', vcsleader .. 'f', mapstr 'G fetch' }
map { 'n', vcsleader .. 'p', mapstr 'G pull' }
map { 'n', vcsleader .. 'P', mapstr 'G push' }
map { 'n', vcsleader .. 's', mapstr 'G status' }
map { 'n', vcsleader .. 'S', mapstr 'G stash' }
map { 'n', vcsleader .. '2', mapstr 'diffget //2' }
map { 'n', vcsleader .. '3', mapstr 'diffget //3' }
map { 'n', vcsleader .. 'l', mapstr 'G log' }
map { 'n', vcsleader .. 'L', mapstr 'G lg' }

-- Telescope
map { 'n', vcsleader .. 'b', mapstr('telescope.builtin', 'git_branches()') }
map { 'n', vcsleader .. 'c', mapstr('telescope.builtin', 'git_commits()') }
map { 'n', vcsleader .. 'B', mapstr 'Gitsigns blame_line' }
map { 'n', vcsleader .. 'w', mapstr('telescope', 'extensions.git_worktree.git_worktrees()') }
map { 'n', vcsleader .. 'W', mapstr('telescope', 'extensions.git_worktree.create_git_worktree()') }
