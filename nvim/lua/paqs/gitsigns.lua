require('gitsigns').setup {
    signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '_' },
        topdelete = { text = '—' },
        changedelete = { text = '▎' },
    },
    update_debounce = 0,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>',
    current_line_blame_opts = {
        delay = 0,
    },
    preview_config = {
        border = 'single',
    },
    on_attach = function(_)
        local utils = require 'utils'
        local bmap, map, mapstr = utils.bmap, utils.map, utils.mapstr

        bmap { 'n', '<leader>gb', mapstr 'Gitsigns blame_line' }
        bmap { 'n', '<leader>gp', mapstr 'Gitsigns preview_hunk' }
        bmap { 'n', '[g', mapstr 'Gitsigns prev_hunk' }
        bmap { 'n', ']g', mapstr 'Gitsigns next_hunk' }

        bmap { 'n', '<leader>vb', mapstr 'FzfLua git_branches' }
        bmap { 'n', '<leader>vh', mapstr 'FzfLua git_bcommits' }
        bmap { 'n', '<leader>vc', mapstr 'FzfLua git_commits' }

        map { 'n', '<leader>vw', mapstr('paqs.worktree', 'git_worktrees()') }

        require 'paqs.fugitive'
    end,
}
