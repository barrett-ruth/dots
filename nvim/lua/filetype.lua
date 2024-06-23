vim.filetype.add({
    extension = {
        log = 'log',
        mdx = 'mdx',
    },
    filename = {
        ['.env'] = 'config',
        ['requirements.txt'] = 'config',
    },
    pattern = {
        ['.env.*'] = 'config',
    },
})
