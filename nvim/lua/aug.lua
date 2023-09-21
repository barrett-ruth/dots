local api = vim.api
local au = api.nvim_create_autocmd
local methods = vim.lsp.protocol.Methods

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

        if client.supports_method(methods.textDocument_inlayHint) then
            bmap({
                'n',
                '\\i',
                function()
                    vim.lsp.inlay_hint(opts.buf)
                end,
            }, { buffer = opts.buf })
        end

        if client.supports_method(methods.textDocument_formatting) then
            local modes = { 'n' }

            if client.supports_method(methods.textDocument_rangeFormatting) then
                modes[#modes + 1] = 'x'
            end

            bmap({
                modes,
                '<leader>w',
                function()
                    local function run_cmd(cmd)
                        if vim.fn.exists(':' .. cmd) then
                            vim.cmd(cmd)
                        end
                    end

                    if client.name == 'eslint' then
                        run_cmd('EslintFixAll')
                    elseif client.name == 'typescript-tools' then
                        for _, cmd in ipairs({
                            'TSToolsRemovedUnused',
                            'TSToolsFixAll',
                            'TSToolsAddMissingImports',
                            'TSToolsOrganizeImports',
                        }) do
                            run_cmd(cmd)
                        end
                    end

                    vim.lsp.buf.format({
                        filter = function(c)
                            return not vim.tbl_contains({
                                'cssls', -- prettier
                                'html', -- prettier
                                'jsonls', -- prettier
                                'pylsp', -- black/autopep8
                                'typescript-tools', -- prettier
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
