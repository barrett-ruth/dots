return {
    filetypes = { 'typst' },
    settings = {
        formatterMode = 'typstyle',
        semanticTokens = 'disable',
        lint = {
            enabled = true,
            when = 'onType',
            -- when = 'onSave'
        },
    },
}
