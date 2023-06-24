local api = vim.api
local au = api.nvim_create_autocmd

local aug = api.nvim_create_augroup('AAugs', {})

au('BufEnter', {
    command = 'setl formatoptions-=cro spelloptions=camel,noplainbuffer',
    group = aug,
})

au('VimResized', {
    command = 'wincmd =',
    group = aug,
})

au('ModeChanged', {
    command = 'let &hlsearch = index(["?", "/"], getcmdtype()) > -1',
    group = aug,
})

au('BufReadPost', {
    command = 'sil! norm g`"',
    group = aug,
})

au('TextYankPost', {
    command = 'lua vim.highlight.on_yank { higroup = "RedrawDebugNormal", timeout = "300" }',
    group = aug,
})

au('LspAttach', {
    callback = function(opts)
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        if client.server_capabilities.inlayHintProvider then
            print('hi')
            vim.lsp.buf.inlay_hint(opts.buf, true)
        end

        if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, opts.buf)
        end

        if client.server_capabilities.documentFormattingProvider then
            bmap({
                'n',
                '<leader>w',
                function()
                    vim.lsp.buf.format({
                        filter = function(c)
                            return not vim.tbl_contains({
                                'clangd', -- clang-format
                                'cssls', -- prettier
                                'html', -- prettier
                                'jedi_language_server', -- black/autopep8
                                'jsonls', -- prettier
                                'pyright', -- black/autopep8
                                'lua_ls', -- stylua
                                'tsserver', -- prettier
                            }, c.name)
                        end,
                    })

                    vim.cmd.w()
                end,
            }, { buffer = opts.buf, silent = false })
        end
    end,
})
