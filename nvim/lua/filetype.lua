vim.filetype.add({
    filename = {
        ['requirements.txt'] = 'config',
        ['.env'] = 'config',
    },
    pattern = {
        ['.env.*'] = 'config',
        ['.*.log'] = 'log',
    },
})
