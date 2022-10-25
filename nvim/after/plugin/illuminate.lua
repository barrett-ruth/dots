require('illuminate').configure {
    delay = 0,
    providers = {
        'treesitter',
        'lsp',
        'regex'
    }
}
