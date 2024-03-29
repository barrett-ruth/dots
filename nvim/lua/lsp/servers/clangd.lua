return {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--clang-tidy-checks=*',
        '-j=4',
        '--background-index',
        '--completion-style=bundled',
        '--header-insertion=iwyu',
        '--header-insertion-decorators=false',
    },
    on_attach = function()
        bmap({ 'n', '\\h', vim.cmd.ClangdSwitchSourceHeader })
    end,
}
