local utils = require 'utils'
local mapstr = utils.mapstr
local map = utils.map

local gitleader = '<leader>g'

-- Fugitive
map { 'n', gitleader .. 'd', mapstr 'G d' }
map { 'n', gitleader .. 'f', mapstr 'G fetch' }
map { 'n', gitleader .. 'p', mapstr 'G pull' }
map { 'n', gitleader .. 'P', mapstr 'G push' }
map { 'n', gitleader .. 's', mapstr 'G status' }
map { 'n', gitleader .. 'S', mapstr 'G stash' }
map { 'n', gitleader .. '2', mapstr 'diffget //2' }
map { 'n', gitleader .. '3', mapstr 'diffget //3' }
map { 'n', gitleader .. 'l', mapstr 'G log' }
map { 'n', gitleader .. 'L', mapstr 'G lg' }

-- Telescope
map { 'n', gitleader .. 'b', mapstr('telescope.builtin', 'git_branches()') }
map { 'n', gitleader .. 'c', mapstr('telescope.builtin', 'git_commits()') }
map { 'n', gitleader .. 'w', mapstr('telescope', 'extensions.git_worktree.git_worktrees()') }
map { 'n', gitleader .. 'W', mapstr('telescope', 'extensions.git_worktree.create_git_worktree()') }
