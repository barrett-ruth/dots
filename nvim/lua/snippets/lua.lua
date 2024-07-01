return {
    s('pr', fmt('vim.print({})', { i(1) })),
    s('afun', fmt('function({})\n\t{}\nend', { i(1), i(2) })),
    s('fun', fmt('function {}({})\n\t{}\nend', { i(1), i(2), i(3) })),
    s('for', fmt('for {} in {} do\n\t{}\nend', { i(1), i(2), i(3) })),
    s('if', fmt('if {} then\n\t{}\nend', { i(1), i(2) })),
}
