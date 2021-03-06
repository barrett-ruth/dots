require('gitsigns').setup {
    attach_to_untracked = false,
    current_line_blame = true,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    current_line_blame_opts = {
        delay = 0,
    },
    on_attach = function(_)
        local signcolumn = vim.wo.signcolumn
        if signcolumn == 'no' then
            vim.wo.signcolumn = 'yes:1'
        elseif signcolumn == 'yes:1' then
            vim.wo.signcolumn = 'yes:2'
        end

        local utils = require 'utils'
        local bmap, map, mapstr = utils.bmap, utils.map, utils.mapstr

        bmap { 'n', '<leader>gb', mapstr 'Gitsigns toggle_current_blame_line' }
        bmap { 'n', '<leader>gp', mapstr 'Gitsigns preview_hunk' }
        bmap { 'n', '[g', mapstr 'Gitsigns prev_hunk' }
        bmap { 'n', ']g', mapstr 'Gitsigns next_hunk' }

        bmap { 'n', '<leader>vb', mapstr('fzf-lua', 'git_branches()') }
        bmap { 'n', '<leader>vh', mapstr 'FzfLua git_bcommits' }
        bmap { 'n', '<leader>vc', mapstr 'FzfLua git_commits' }

        map { 'n', '<leader>vw', mapstr('paqs.worktree', 'git_worktrees()') }

        require 'paqs.fugitive'
    end,
    preview_config = {
        border = 'single',
    },
    update_debounce = 0,
}

local gitsigns_signs = {
    Add = { text = '▎' },
    Change = { text = '▎' },
    Changedelete = { text = '~' },
    Delete = { text = '_' },
    Topdelete = { text = '‾' },
}

for name, v in pairs(gitsigns_signs) do
    vim.fn.sign_define('GitSigns' .. name, { text = v.text })
end
