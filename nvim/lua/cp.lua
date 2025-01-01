vim.api.nvim_create_user_command('CP', function()
    vim.diagnostic.enable(false)

    vim.cmd('50vsplit output.txt')
    vim.cmd.split('input.txt')
    vim.cmd.wincmd('h')
    vim.cmd('vertical resize +8')

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
            vim.fn.system(
                ('sh -c "g++ %s 2>output.txt && test -f a.out && ./a.out >output.txt && rm a.out"'):format(
                    vim.fn.expand('%')
                )
            )
            vim.cmd('checktime')
            if vim.v.shell_error == 0 then
                vim.lsp.buf.format()
            end
        end,
    })
end, {})
