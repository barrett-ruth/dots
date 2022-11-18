local status, gitsigns = pcall(require, 'gitsigns')

if not status then
    return
end

local builtin = require 'telescope.builtin'

gitsigns.setup {
    attach_to_untracked = false,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    current_line_blame_opts = { delay = 0 },
    on_attach = function(_)
        bmap { 'n', '<leader>gp', gitsigns.preview_hunk }
        bmap { 'n', '<leader>gs', gitsigns.stage_hunk }

        bmap { 'n', '[g', gitsigns.prev_hunk }
        bmap { 'n', ']g', gitsigns.next_hunk }

        bmap { 'n', '<leader>gb', builtin.git_branches }
        bmap { 'n', '<leader>gc', builtin.git_commits }
        bmap { 'n', '<leader>gh', builtin.git_bcommits }

        local git_worktree = require('telescope').extensions.git_worktree
        bmap { 'n', '<leader>gw', git_worktree.git_worktrees }
        bmap { 'n', '<leader>gW', git_worktree.create_git_worktree }
    end,
    preview_config = {
        border = 'single',
    },
    update_debounce = 0,
}

local gitsigns_signs = {
    Add = { text = '│' },
    Change = { text = '│' },
    Changedelete = { text = '~' },
    Delete = { text = '_' },
    Topdelete = { text = '‾' },
}

for name, v in pairs(gitsigns_signs) do
    vim.fn.sign_define('GitSigns' .. name, { text = v.text })
end
