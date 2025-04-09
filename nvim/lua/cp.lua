local lsp_format = require('lsp').lsp_format

local M = {}

local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', '', { scope = 'local' })
    vim.api.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local types = { 'usaco', 'cf', 'icpc', 'cses' }

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
        local input = base_filepath .. '.in'
        vim.cmd('50vsplit ' .. input)
        local input_buf = vim.api.nvim_get_current_buf()
        vim.cmd.w()
        clearcol()
        vim.cmd.wincmd('h')

        -- Configure keymaps
        local function move_problem(delta)
            local base_filename = vim.fn.fnamemodify(base_filepath, ':t')
            local next_filename_byte = base_filename:byte() + delta
            if next_filename_byte < ('a'):byte() then
                return
            end
            local delta_filename = (string.char(next_filename_byte) .. '.cc')
            vim.cmd.wall()
            vim.cmd.e(delta_filename)
            vim.cmd.bwipeout(input_buf)
            vim.cmd.CP(type_)
        end

        vim.keymap.set('n', ']]', function()
            move_problem(1)
        end, { buffer = code })
        vim.keymap.set('n', '[[', function()
            move_problem(-1)
        end, { buffer = code })

        bmap({
            'n',
            '<leader>m',
            function()
                lsp_format()
                vim.api.nvim_set_option_value(
                    'makeprg',
                    ('CP run %% %s'):format(version),
                    { buf = code }
                )
                vim.cmd.make()
            end,
        }, { buffer = code })

        bmap({
            'n',
            '<leader>d',
            function()
                lsp_format()
                vim.api.nvim_set_option_value(
                    'makeprg',
                    ('CP debug %% %s'):format(version),
                    { buf = code }
                )
                vim.cmd.make()
            end,
        }, { buffer = code })
    end, { nargs = 1 })
end

return M
