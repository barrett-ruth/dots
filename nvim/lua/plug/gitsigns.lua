require('gitsigns').setup {
    sign_priority = 0,
    update_debounce = 0,
    current_line_blame = true,
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>',
    current_line_blame_opts = {
        delay = 0,
        insert_mode = false,
    },
    preview_config = {
        border = 'none',
    },
    on_attach = function(_)
        local utils = require 'utils'
        local mapstr = utils.mapstr
        local bmap = utils.bmap

        local blameleader = '<leader>v'

        bmap { 'n', blameleader .. 'b', mapstr 'Gitsigns blame_line' }
        bmap { 'n', blameleader .. 'B', mapstr 'Gitsigns toggle_current_line_blame' }
        bmap { 'n', blameleader .. 'p', mapstr 'Gitsigns preview_hunk' }
        bmap { 'n', '[g', mapstr 'Gitsigns prev_hunk' }
        bmap { 'n', ']g', mapstr 'Gitsigns next_hunk' }
    end,
}
