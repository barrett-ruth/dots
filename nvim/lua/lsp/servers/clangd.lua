return {
    filetypes = { 'c', 'cpp' },
    cmd = { "socat", "-", "TCP:localhost:12345" },
    -- cmd = {
    --     'clangd',
    --     '--clang-tidy',
    --     '-j=4',
    --     '--log=verbose',
    --     '--background-index',
    --     '--completion-style=bundled',
    --     '--header-insertion=iwyu',
    --     '--header-insertion-decorators=false',
    -- },
    on_attach = function()
        bmap({ 'n', '\\h', vim.cmd.ClangdSwitchSourceHeader })
    end,
}
