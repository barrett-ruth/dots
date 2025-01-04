local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', ' ', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

vim.api.nvim_create_user_command('CP', function()
    vim.diagnostic.enable(false)

    vim.cmd('50vsplit output.txt')
    clearcol()
    vim.cmd.split('input.txt')
    clearcol()
    vim.cmd.wincmd('h')
    vim.cmd('vertical resize +8')

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
            vim.fn.jobstart(
                ('g++ %s 2>output.txt && test -f a.out && cat input.txt | ./a.out >output.txt && rm a.out'):format(
                    vim.fn.expand('%')
                ),
                {
                    on_exit = function(_, exit_code, _)
                        vim.cmd.checktime()

                        if exit_code == 0 then
                            vim.lsp.buf.format()
                        end
                    end,
                }
            )
        end,
    })
end, {})
