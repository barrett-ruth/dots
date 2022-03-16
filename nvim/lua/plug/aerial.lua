require('aerial').setup {
    width = 0.4,
    manage_folds = true,
    link_tree_to_folds = true,
    highlight_on_jump = false,
    post_jump_cmd = 'norm! zz',
    on_attach = function(_)
        local utils = require 'utils'
        local mapstr = utils.mapstr

        utils.map { 'n', '<leader>a', mapstr 'AerialToggle' }
        utils.bmap { 'n', '<c-s>', mapstr('telescope', 'extensions.aerial.aerial()') }
    end,
}
