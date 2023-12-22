local api = vim.api
local au = api.nvim_create_autocmd

local aug = api.nvim_create_augroup('AAugs', {})

au('BufEnter', {
    command = 'setl formatoptions-=cro spelloptions=camel,noplainbuffer',
    group = aug,
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

local methods = vim.lsp.protocol.Methods

local function format()
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

    for _, cmd in ipairs({
        'TSToolsAddMissingImports',
        'TSToolsOrganizeImports',
        'TSToolsFixAll',
        'EslintFixAll',
    }) do
        if vim.fn.exists(':' .. cmd) ~= 0 then
            vim.fn.execute(cmd)
        end
    end
end


au('LspAttach', {
    callback = function(opts)
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        if not client then
            return
        end

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
                format,
            }, { buffer = opts.buf, silent = false })
        end
    end,
    group = aug,
})
