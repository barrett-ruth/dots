local status, gitsigns = pcall(require, 'gitsigns')

if not status or not vim.tbl_contains({ '', 'utf-8' }, vim.bo.fenc) then
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
        border = 'rounded',
    },
    update_debounce = 0,
}

local fn = vim.fn

fn.sign_define('GitSignsAdd', { text = '│' })
fn.sign_define('GitSignsChange', { text = '│' })
fn.sign_define('GitSignsChangedelete', { text = '~' })
fn.sign_define('GitSignsDelete', { text = '＿' })
fn.sign_define('GitSignsTopdelete', { text = '‾' })
