require('dirbuf').setup {
    show_hidden = false,
    sort_order = 'directories_first',
}

map { 'n', '<leader>e', '<cmd>e .<cr>' }
