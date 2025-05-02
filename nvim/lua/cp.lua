local lsp_format = require('lsp').lsp_format

local M = {}

local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', '', { scope = 'local' })
    vim.api.nvim_set_option_value('signcolumn', 'no', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local competition_versions =
    { codeforces = 23, cses = 20, icpc = 20, usaco = 17 }

local competition_types = vim.tbl_keys(competition_versions)

function M.setup()
    vim.api.nvim_create_user_command('CP', function(opts)
        local competition_type, fname = opts.fargs[1], opts.fargs[2]

        if not vim.tbl_contains(competition_types, competition_type) then
            vim.schedule(function()
                vim.notify_once(
                    ('Enter competition of type: [%s]'):format(
                        table.concat(competition_types, ', ')
                    ),
                    vim.log.levels.ERROR
                )
            end)
            return
        end

        local code = vim.api.nvim_get_current_buf()

        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(buf)
            if
                name:match('/io/[^/]+%.in$') or name:match('/io/[^/]+%.out$')
            then
                vim.api.nvim_win_close(win, true)
            end
        end

        vim.cmd.wall()
        vim.cmd.e(fname)

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
                .. '/cp-template/* . && make setup VERSION='
                .. competition_versions[competition_type]
        )

        vim.diagnostic.enable(false)

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
        -- 30% split
        vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.3))
        vim.cmd.split(input)
        vim.cmd.w()
        clearcol()
        vim.cmd.wincmd('h')

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
        nargs = '+',
        complete = function(ArgLead, CmdLine, ...)
            if #CmdLine <= 3 then
                return competition_types
            end
            return vim.tbl_filter(function(e)
                return vim.tbl_contains(
                    { '.py', '.cpp', '.cc' },
                    vim.fn.fnamemodify(e, ':t')
                )
            end, vim.fn.glob(ArgLead .. '*', false, true))
        end,
    })
end

return M
