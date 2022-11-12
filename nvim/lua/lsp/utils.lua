local M = {}

local format = function()
    vim.lsp.buf.format {
        async = true,
        filter = function(client)
            return not vim.tbl_contains({
                'clangd', -- clang-format
                'cssls', -- prettierd
                'html', -- prettierd
                'jedi_language_server', -- black/autopep8
                'jsonls', -- prettierd
                'pyright', -- black/autopep8
                'sqls', -- sql-formatter
                'sumneko_lua', --stylua
                'tsserver', -- prettierd
            }, client.name)
        end,
    }
end

local api = vim.api

local builtin = require 'telescope.builtin'

local rename = function()
    local old_name = vim.fn.expand '<cword>'

    local bufnr = api.nvim_create_buf(false, true)
    local win = api.nvim_open_win(bufnr, true, {
        style = 'minimal',
        border = 'single',
        relative = 'cursor',
        row = 1,
        col = -1,
        width = math.floor(old_name:len() > 20 and old_name:len() * 1.5 or 20),
        height = 1,
    })

    api.nvim_buf_set_lines(bufnr, 0, -1, true, { old_name })

    bmap({ 'i', '<c-c>', vim.cmd.q }, { buffer = bufnr })
    bmap({ 'n', 'q', vim.cmd.q }, { buffer = bufnr })
    bmap({
        { 'i', 'n' },
        '<cr>',
        function()
            local new_name = vim.trim(vim.fn.getline '.')

            api.nvim_win_close(win, true)

            if require('utils').empty(new_name) or new_name == old_name then
                return
            end

            vim.lsp.buf.rename(new_name)

            api.nvim_input '<esc>l'
        end,
    }, { buffer = bufnr })
end

M.on_attach = function(client, _)
    local server_capabilities = client.server_capabilities
    local diagnostic, buf = vim.diagnostic, vim.lsp.buf

    if server_capabilities.documentFormattingProvider then
        bmap {
            'n',
            '<leader>w',
            function()
                vim.cmd.w()
                format()
            end,
        }
    end

    if server_capabilities.codeActionProvider then
        bmap { 'n', '\\c', buf.code_action }
    end

    if server_capabilities.definitionProvider then
        bmap { 'n', '\\d', builtin.lsp_definitions }
    end

    bmap { 'n', '\\e', builtin.diagnostics }

    if server_capabilities.declarationProvider then
        bmap { 'n', '\\D', buf.declaration }
    end

    if server_capabilities.implementationProvider then
        bmap { 'n', '\\i', builtin.lsp_implementations }
    end

    bmap { 'n', '\\f', diagnostic.open_float }

    if server_capabilities.hoverProvider then bmap { 'n', '\\h', buf.hover } end

    if server_capabilities.renameProvider then bmap { 'n', '\\r', rename } end

    if server_capabilities.referencesProvider then
        bmap { 'n', '\\R', builtin.lsp_references }
    end

    if server_capabilities.signatureHelpProvider then
        require('lsp.signature').setup(client)
        bmap { 'i', '<c-space>', buf.signature_help }
    end

    if server_capabilities.documentSymbolProvider then
        bmap {
            'n',
            '\\sa',
            function()
                builtin.lsp_document_symbols {
                    ignore_symbols = {
                        'array',
                        'constant',
                        'enummember',
                        'field',
                        'string',
                        'variable',
                    },
                }
            end,
        }
        bmap {
            'n',
            '\\sc',
            function() builtin.lsp_document_symbols { symbols = 'Class' } end,
        }
        bmap {
            'n',
            '\\sf',
            function() builtin.lsp_document_symbols { symbols = 'Function' } end,
        }
    end

    if server_capabilities.typeDefinitionProvider then
        bmap { 'n', '\\t', builtin.lsp_type_definitions }
    end

    bmap { 'n', ']\\', diagnostic.goto_next }
    bmap { 'n', '[\\', diagnostic.goto_prev }

    bmap { 'n', '\\li', '<cmd>LspInfo<cr>' }
    bmap { 'n', '\\lI', '<cmd>NullLsInfo<cr>' }
    bmap { 'n', '\\ll', '<cmd>LspLog<cr>' }
    bmap { 'n', '\\lL', '<cmd>NullLsLog<cr>' }
    bmap { 'n', '\\lr', '<cmd>LspRestart<cr>' }
    bmap { 'n', '\\lR', '<cmd>NullLsRestart<cr>' }
end

M.prepare_lsp_settings = function(settings)
    local default_settings = {}

    default_settings.capabilities = vim.lsp.protocol.make_client_capabilities()
    default_settings.capabilities.offsetEncoding = { 'utf-16' }
    default_settings.capabilities.textDocument.completion.completionItem.snippetSupport =
        false
    default_settings.flags = { debounce_text_changes = 0 }
    default_settings.on_attach = M.on_attach

    return vim.tbl_extend('force', default_settings, settings)
end

return M
