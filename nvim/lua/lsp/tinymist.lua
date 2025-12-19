return {
    filetypes = { 'typst' },
    settings = {
        formatterMode = 'typstyle',
        exportPdf = 'onType',
        semanticTokens = 'disable',
        lint = {
            enabled = true,
            when = 'onType',
            -- when = 'onSave'
        },
    },
}
