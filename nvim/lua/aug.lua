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

au('TermOpen', {
    command = 'startinsert | setl nonumber norelativenumber statuscolumn=',
    group = aug,
})

au('BufReadPost', {
    command = 'sil! normal g`"',
    group = aug,
})

au('LspAttach', {
    callback = function(opts)
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        if client.server_capabilities.inlayHintProvider then
            bmap({
                'n',
                '\\i',
                function()
                    vim.lsp.inlay_hint(opts.buf)
                end,
            }, { buffer = opts.buf })
        end

        if client.server_capabilities.documentFormattingProvider then
            local modes = { 'n' }

            if client.server_capabilities.documentRangeFormattingProvider then
                table.insert(modes, 'x')
            end

            bmap({
                modes,
                '<leader>w',
                function()
                    vim.lsp.buf.format({
                        filter = function(c)
                            return not vim.tbl_contains({
                                'clangd', -- clang-format
                                'cssls', -- prettier
                                'html', -- prettier
                                'jsonls', -- prettier
                                'pylsp', -- black/autopep8
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

au({ 'BufRead', 'BufNewFile' }, {
    pattern = '*/templates/*.html',
    callback = function(opts)
        vim.api.nvim_set_option_value(
            'filetype',
            'htmldjango',
            { buf = opts.buf }
        )
    end,
    group = aug,
})
