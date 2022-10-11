require('template-string').setup {
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    jsx_brackets = true,
    remove_template_string = true,
    restore_quotes = {
        normal = [[']],
        jsx = [["]],
    },
}
