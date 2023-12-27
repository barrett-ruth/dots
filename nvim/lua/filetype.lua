vim.filetype.add({
    extension = {
        log = 'log',
        mdx = 'jsx',
    },
    filename = {
        ['.env'] = 'config',
        ['requirements.txt'] = 'config',
    },
    pattern = {
        ['.env.*'] = 'config',
    },
})
