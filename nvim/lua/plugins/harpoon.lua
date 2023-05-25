return {
    'ThePrimeagen/harpoon',
    keys = {
        { '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<cr>' },
        { '<leader>hd', '<cmd>lua require("harpoon.mark").rm_file()<cr>' },
        {
            '<leader>hq',
            '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
        },
        { '<leader>hn', '<cmd>lua require("harpoon.ui").nav_next()<cr>' },
        { '<leader>hp', '<cmd>lua require("harpoon.ui").nav_prev()<cr>' },
        { '<c-h>', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>' },
        { '<c-j>', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>' },
        { '<c-k>', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>' },
        { '<c-l>', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>' },
    },
}
