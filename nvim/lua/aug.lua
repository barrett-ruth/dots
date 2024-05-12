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

au({ 'FileType' }, {
    callback = function(e)
        local cs = vim.bo[e.buf].commentstring
        vim.bo[e.buf].commentstring = cs:gsub('(%S)%%s', '%1 %%s')
            :gsub('%%s(%S)', '%%s %1')
    end,
})

au('ColorScheme', {
    pattern = '*',
    callback = function()
        vim.o.statusline =
            [[%{%v:lua.require('lines.statusline').statusline()%}]]
        vim.o.statuscolumn =
            [[%{%v:lua.require('lines.statuscolumn').statuscolumn()%}]]
    end,
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
    vim.cmd.w()
end

au('LspAttach', {
    callback = function(opts)
        local client = vim.lsp.get_client_by_id(opts.data.client_id)

        if not client then
            return
        end

        if client.server_capabilities.documentFormattingProvider then
            local modes = { 'n' }

            if client.server_capabilities.documentRangeFormattingProvider then
                table.insert(modes, 'x')
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
