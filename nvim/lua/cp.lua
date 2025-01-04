local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', ' ', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local compile_flags = {
    '-O2',
    '-march=native',
    '-std=c++17',
    '-Wall',
    '-Wextra',
    '-Wshadow',
    '-fsanitize=address,undefined',
    '-fstack-protector',
    '-fno-omit-frame-pointer',
    '-g',
    '-DLOCAL',
}

local types = { 'usaco', 'cf' }

vim.api.nvim_create_user_command('CP', function(opts)
    local type_ = opts.args
    if not vim.tbl_contains(types, type_) then
        vim.notify_once(
            ('Must specify competition of type: []'):format(
                table.concat(types, ', ')
            ),
            vim.log.levels.ERROR
        )
    end

    vim.diagnostic.enable(false)
    vim.api.nvim_input('i' .. type_ .. '<c-s>')

    local input, output = 'input.txt', 'output.txt'
    if type_ == 'usaco' then
        local filename = vim.fn.expand('%:t:r')
        input, output = filename .. '.in', filename .. '.out'
    end

    vim.cmd('50vsplit ' .. output)
    clearcol()
    vim.cmd.split(input)
    clearcol()
    vim.cmd.wincmd('h')
    vim.cmd('vertical resize +8')

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
            vim.fn.jobstart(
                ('g++ %s %s 2>%s && test -f a.out && cat %s | ./a.out >%s && rm a.out'):format(
                    table.concat(compile_flags, ' '),
                    vim.fn.expand('%'),
                    output,
                    input,
                    output
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
end, { nargs = 1 })
