vim.filetype.add({
    extension = {
        log = 'log',
        mdx = 'mdx',
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'jinja',
    },
    filename = {
        ['.env'] = 'config',
        ['requirements.txt'] = 'config',
    },
    pattern = {
        ['.env.*'] = 'config',
    },
})
