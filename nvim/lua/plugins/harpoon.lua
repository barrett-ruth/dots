return {
    'ThePrimeagen/harpoon',
    config = function()
        local mark, ui = require('harpoon.mark'), require('harpoon.ui')

        map({ 'n', '<leader>ha', mark.add_file })
        map({ 'n', '<leader>hd', mark.rm_file })

        map({ 'n', '<leader>hq', ui.toggle_quick_menu })
        map({ 'n', '<leader>hn', ui.nav_next })
        map({ 'n', '<leader>hp', ui.nav_prev })

        map({
            'n',
            '<c-h>',
            function()
                ui.nav_file(1)
            end,
        })
        map({
            'n',
            '<c-j>',
            function()
                ui.nav_file(2)
            end,
        })
        map({
            'n',
            '<c-k>',
            function()
                ui.nav_file(3)
            end,
        })
        map({
            'n',
            '<c-l>',
            function()
                ui.nav_file(4)
            end,
        })
    end,
}
