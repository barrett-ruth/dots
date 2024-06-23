vim.filetype.add({
    extension = {
        log = 'log',
        mdx = 'mdx',
    },
    filename = {
        ['requirements.txt'] = 'config',
    },
    pattern = {
        ['.env*'] = 'sh',
    },
})
