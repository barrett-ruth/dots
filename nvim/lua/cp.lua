local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', '', { scope = 'local' })
    vim.api.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local types = { 'usaco', 'cf', 'icpc', 'cses' }

local M = { _enabled = {}, last = {}, time = {} }

function M.setup()
    vim.api.nvim_create_user_command('CP', function(opts)
        local type_ = opts.args
        if not vim.tbl_contains(types, type_) then
            vim.notify_once(
                ('Must specify competition of type: [%s]'):format(
                    table.concat(types, ', ')
                ),
                vim.log.levels.ERROR
            )
            return
        end

        local version = type_ == 'cses' and '20' or '23'

        local code = vim.api.nvim_get_current_buf()

        -- Disable LSP
        vim.diagnostic.enable(false, { bufnr = code })

        -- Configure options
        vim.api.nvim_set_option_value('foldlevel', 0, { scope = 'local' })
        vim.api.nvim_set_option_value(
            'foldmethod',
            'marker',
            { scope = 'local' }
        )
        vim.api.nvim_set_option_value(
            'foldmarker',
            '{{{,}}}',
            { scope = 'local' }
        )


        -- Populate coding buffer
        if vim.api.nvim_buf_get_lines(0, 0, -1, true)[1] == '' then
            -- enter normal mode to trigger folding
            vim.api.nvim_input('i' .. type_ .. '<c-space><esc>')
        end

        -- Configure windows
        local filename = vim.fn.expand('%')
        local base_filepath = vim.fn.fnamemodify(filename, ':p:r')
        local input, output = base_filepath .. '.in', base_filepath .. '.out'

        vim.cmd('50vsplit ' .. output)
        local output_buf = vim.api.nvim_get_current_buf()
        vim.cmd.w()
        clearcol()
        vim.cmd.split(input)
        local input_buf = vim.api.nvim_get_current_buf()
        vim.cmd.w()
        clearcol()
        vim.cmd.wincmd('h')
        vim.cmd('vertical resize +8')

        -- Configure keymaps
        local function move_problem(delta)
            local base_filename = vim.fn.fnamemodify(base_filepath, ':t')
            local next_filename_byte = base_filename:byte() + delta
            if
                next_filename_byte < ('a'):byte()
                or next_filename_byte > ('z'):byte()
            then
                return
            end
            local delta_filename = (string.char(next_filename_byte) .. '.cc')
            local delta_py_filename = (string.char(next_filename_byte) .. '.py')
            if vim.loop.fs_stat(delta_py_filename) ~= nil then
                delta_filename = (string.char(next_filename_byte) .. '.py')
            end
            vim.cmd.wall()
            vim.cmd.bwipeout(input_buf)
            vim.cmd.bwipeout(output_buf)
            vim.cmd.e(delta_filename)
            vim.cmd.CP(type_)
        end

        for _, buf in ipairs({ code, output_buf, input_buf }) do
            vim.keymap.set('n', ']]', function()
                move_problem(1)
            end, { buffer = buf })
            vim.keymap.set('n', '[[', function()
                move_problem(-1)
            end, { buffer = true })
        end

        local function on_exit(_, exit_code)
            vim.cmd.checktime()
            if exit_code ~= 0 then
                vim.diagnostic.enable(true, { buf = code })
            end
        end

        vim.api.nvim_create_autocmd('BufWritePost', {
            pattern = input,
            callback = function()
                vim.cmd.wall()
                vim.fn.jobstart({ 'CP', 'run', filename, version }, {
                    on_exit = on_exit,
                })
            end,
        })

        vim.keymap.set('n', '<leader>w', function()
            vim.cmd.wall()
            vim.lsp.buf.format({ async = true })
            vim.fn.jobstart({ 'CP', 'run', filename, version }, {
                on_exit = on_exit,
            })
        end, { buffer = true })

        vim.keymap.set('n', '<leader>d', function()
            vim.cmd.w()
            vim.lsp.buf.format({ async = true })
            vim.fn.jobstart({ 'CP', 'debug', filename, version }, {
                on_exit = on_exit,
            })
        end, { buffer = true })
    end, { nargs = 1 })
end

return M
