return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '-j=4',
        '--background-index',
        '--header-insertion=iwyu',
        '--header-insertion-decorators',
    },
    on_attach = function()
        bmap({ 'n', '\\h', '<cmd>ClangdSwitchSourceHeader<cr>' })
    end,
}
