local lsp_format = require('lsp').lsp_format

local M = {}

local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', '', { scope = 'local' })
    vim.api.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local competition_types = { 'codeforces', 'cses', 'icpc', 'usaco' }

function M.setup()
    vim.api.nvim_create_user_command('CP', function(opts)
        local competition_type = opts.args
        if not vim.tbl_contains(competition_types, competition_type) then
            vim.notify_once(
                ('Must specify competition of type: [%s]'):format(
                    table.concat(competition_types, ', ')
                ),
                vim.log.levels.ERROR
            )
            return
        end

        local code = vim.api.nvim_get_current_buf()

        -- options
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
            vim.api.nvim_input('i' .. competition_type .. '<c-space><esc>')
        end

        vim.fn.system(
            'cp -fr '
                .. vim.env.XDG_CONFIG_HOME
                .. '/cp-template/* . && make setup'
        )

        -- windows
        local filename = vim.fn.expand('%')
        local base_fp, basename =
            vim.fn.fnamemodify(filename, ':p:h'),
            vim.fn.fnamemodify(filename, ':t:r')
        local input, output =
            ('%s/io/%s.in'):format(base_fp, basename),
            ('%s/io/%s.out'):format(base_fp, basename)
        vim.cmd.vsplit(output)
        vim.cmd.w()
        clearcol()
        local output_buf = vim.api.nvim_get_current_buf()
        -- 30% split
        vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.3))
        vim.cmd.split(input)
        vim.cmd.w()
        clearcol()
        local input_buf = vim.api.nvim_get_current_buf()
        vim.cmd.wincmd('h')

        -- keymaps
        local function move_problem(delta)
            local base_filename = vim.fn.fnamemodify(base_fp, ':t')
            local next_filename_byte = base_filename:byte() + delta
            if next_filename_byte < ('a'):byte() then
                return
            end
            local delta_filename = (string.char(next_filename_byte) .. '.cc')
            vim.cmd.wall()
            vim.cmd.e(delta_filename)
            vim.cmd.bwipeout(output_buf)
            vim.cmd.bwipeout(input_buf)
            vim.cmd.CP(competition_type)
        end

        vim.keymap.set('n', ']]', function()
            move_problem(1)
        end, { buffer = code })
        vim.keymap.set('n', '[[', function()
            move_problem(-1)
        end, { buffer = code })

        local filename_basename = vim.fn.fnamemodify(filename, ':t')
        bmap({
            'n',
            '<leader>m',
            function()
                lsp_format({ async = true })
                vim.system({ 'make', 'run', filename_basename }, {}, function()
                    vim.schedule(function()
                        vim.cmd.checktime()
                    end)
                end)
            end,
        }, { buffer = code })

        bmap({
            'n',
            '<leader>d',
            function()
                lsp_format({ async = true })
                vim.system(
                    { 'make', 'debug', filename_basename },
                    {},
                    function()
                        vim.schedule(function()
                            vim.cmd.checktime()
                        end)
                    end
                )
            end,
        }, { buffer = code })
    end, {
        nargs = 1,
        complete = function()
            return competition_types
        end,
    })
end

return M
