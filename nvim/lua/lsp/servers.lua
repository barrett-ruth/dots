local shell = {
    lintCommand = 'shellcheck -f gcc -x -',
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
    clangd = {},
    cssls = {},
    dockerls = {},
    efm = {
        filetypes = { 'bash', 'sh' },
        init_options = {
            log_file = '/tmp/efm.log',
            log_level = 10,
        },
        settings = {
            languages = {
                sh = { shell },
                bash = { shell },
            },
        },
    },
    eslint = {},
    html = {},
    jsonls = {},
    pyright = {},
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                completion = { keywordSnippet = 'Disable' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                },
            },
        },
    },
    tsserver = {},
    vimls = {},
}

local setup = require('lsp/setup').setup

for name, info in pairs(servers) do
    setup(name, info)
end
