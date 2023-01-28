return {
    {
        'echasnovski/mini.bufremove',
        config = function()
            local bufremove = require 'mini.bufremove'

            bufremove.setup {}

            map { 'n', '<leader>bd', bufremove.delete }
            map { 'n', '<leader>bw', bufremove.wipeout }
        end,
    },
    {
        'echasnovski/mini.ai',
        config = function()
            require('mini.ai').setup()
        end,
    },
}
