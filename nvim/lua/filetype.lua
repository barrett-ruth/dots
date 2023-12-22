vim.filetype.add({
    extension = {
        log = 'log',
    },
    filename = {
        ['.env'] = 'config',
        ['requirements.txt'] = 'config',
    },
    pattern = {
        ['.env.*'] = 'config',
    },
})
