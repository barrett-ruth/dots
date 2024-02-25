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

au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 300 })
    end,
    group = aug,
})

local function format()
    vim.lsp.buf.format({
        filter = function(c)
            return not vim.tbl_contains({
                'cssls', -- prettier
                'html', -- prettier
                'jsonls', -- prettier
                'pylsp', -- black/isort/autopep8
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

    vim.cmd.w()
end

au('LspAttach', {
    callback = function(opts)
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        if not client then
            return
        end

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
