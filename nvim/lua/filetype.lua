vim.filetype.add({
    extension = {
        log = 'log',
        mdx = 'mdx',
        dunstrc = 'config',
    },
    filename = {
        ['requirements.txt'] = 'config',
    },
    pattern = {
        ['.env*'] = 'sh',
    },
})
