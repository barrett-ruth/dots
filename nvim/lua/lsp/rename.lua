return {
    _rename = function(winnr)
        local name = vim.trim(vim.fn.getline('.'))
        vim.api.nvim_win_close(winnr, true)
        vim.lsp.buf.rename(name)
    end,
    rename = function()
        local cword = vim.fn.expand('<cword>')
        local bufnr = vim.api.nvim_create_buf(false, true)
        local winnr = vim.api.nvim_open_win(bufnr, true, {
            relative = 'cursor',
            row = 1,
            col = 0,
            width = math.max(15, math.floor(cword:len() * 1.75)),
            height = 1,
            style = 'minimal',
            border = 'single',
        })
        local fmt =
            '<cmd>stopinsert<cr><cmd>lua require("lsp.rename")._rename(%d)<cr>'

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { cword })
        bmap({ 'i', '<c-c>', vim.cmd.q })
        bmap({ 'n', 'q', vim.cmd.q })
        bmap({ 'n', '<cr>', string.format(fmt, winnr) }, { buffer = bufnr })
        bmap({ 'i', '<cr>', string.format(fmt, winnr) }, { buffer = bufnr })
    end,
}
