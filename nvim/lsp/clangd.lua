local config = require('projects')

local default_settings = {
    filetypes = { 'c', 'cpp' },
    on_attach = function()
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

return vim.tbl_extend('force', default_settings, project_settings or {})
