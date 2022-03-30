local fts = {
    refactor = {
        extract = { lua = 'local ' },
        print = {
            javascript = { l = 'console.log(', r = ')' },
            javascriptreact = { l = 'console.log(', r = ')' },
            lua = { l = 'print(', r = ')' },
            python = { l = 'print(', r = ')' },
            typescript = { l = 'console.log(', r = ')' },
            typescriptreact = { l = 'console.log(', r = ')' },
        },
    },
}

return fts
