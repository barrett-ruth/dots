local config = require('projects')

local clangd_settings = {
    filetypes = { 'c', 'cpp' },
    on_attach = function(...)
        require('lsp').on_attach(...)
        bmap({ 'n', 'gh', vim.cmd.ClangdSwitchSourceHeader })
    end,
    cmd = {
        'clangd',
        '--clang-tidy',
        '-j=4',
        '--background-index',
        '--completion-style=bundled',
        '--header-insertion=iwyu',
        '--header-insertion-decorators=false',
    },
}

local project_settings = (config.lsp and config.lsp.clangd)
    and config.lsp.clangd

return vim.tbl_extend('force', clangd_settings, project_settings or {})
