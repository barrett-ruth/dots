return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--header-insertion=iwyu',
    },
    on_attach = function()
        bmap({ 'n', '\\h', '<cmd>ClangdSwitchSourceHeader<cr>' })
    end,
}
