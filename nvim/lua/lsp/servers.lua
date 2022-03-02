local util = require('lspconfig').util
local scriptroots = util.root_pattern(
    '.git',
    'package-lock.json',
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    'tslint.json',
    'eslint.json'
)

local efmshell = {
    lintCommand = 'shellcheck -f gcc -x -',
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
}

local servers = {
    clangd = { filetypes = { 'c', 'cpp' } },
    cssls = { filetypes = { 'css', 'scss', 'less' } },
    dockerls = { filetypes = { 'dockerfile' } },
    efm = {
        filetypes = { 'bash', 'sh' },
        init_options = {
            log_file = '/tmp/efm.log',
            log_level = 10,
        },
        settings = {
            languages = {
                sh = { efmshell },
                bash = { efmshell },
            },
        },
    },
    eslint = { root_dir = scriptroots },
    html = { filetypes = { 'html' } },
    jsonls = { filetypes = { 'json' } },
    pyright = { filetypes = { 'python' } },
    sumneko_lua = {
        filetypes = { 'lua' },
        settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
    },
    tsserver = { root_dir = scriptroots },
    vimls = { filetypes = { 'vim' } },
}

local setup = require('lsp/setup').setup

for name, info in pairs(servers) do
    setup(name, info)
end
