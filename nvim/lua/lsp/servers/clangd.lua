return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '-j=4',
        '--background-index',
        '--completion-style=bundled',
        '--header-insertion=iwyu',
        '--header-insertion-decorators=false',
    },
    on_attach = function()
        bmap({ 'n', '\\h', '<cmd>ClangdSwitchSourceHeader<cr>' })
    end,
}
