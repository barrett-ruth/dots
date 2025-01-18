local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', ' ', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local function find_buf(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(buf) == name then
            return buf
        end
    end
end

local compile_flags = [[-std=c++20
-Wall
-Wextra
-Wshadow
-DLOCAL]]

local clang_format = [[BasedOnStyle: Google
AllowShortFunctionsOnASingleLine: Empty]]

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
        return
    end

    -- Update compile flags & format config
    -- Do this first so LSP reads & configures
    vim.fn.jobstart(
        ('test -f compile_flags.txt || echo "%s" >compile_flags.txt; test -f .clang-format || echo "%s" >.clang-format'):format(
            compile_flags,
            clang_format
        ),
        {
            on_exit = function()
                vim.cmd.LspRestart()
            end,
        }
    )

    -- vim.diagnostic.enable(false)

    -- Populate coding buffer
    if vim.api.nvim_buf_get_lines(0, 0, -1, true)[1] == '' then
        vim.api.nvim_input('i' .. type_ .. '<c-s>')
    end

    -- Configure window
    local filename = vim.fn.expand('%')
    local base_filepath = vim.fn.expand('%:p:r')
    local exename = vim.trim(vim.fn.system('mktemp'))
    local input, output = base_filepath .. '.in', base_filepath .. '.out'

    vim.cmd('50vsplit ' .. output)
    vim.cmd.w()
    clearcol()
    vim.cmd.split(input)
    vim.cmd.w()
    clearcol()
    vim.cmd.wincmd('h')
    vim.cmd('vertical resize +8')

    local input_buf, output_buf = find_buf(input), find_buf(output)

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
        vim.cmd.wall()
        vim.cmd.bwipeout(input_buf)
        vim.cmd.bwipeout(output_buf)
        vim.cmd.e(delta_filename)
        vim.cmd.CP(type_)
    end

    vim.keymap.set('n', ']]', function()
        move_problem(1)
    end, { buf = opts.buf })
    vim.keymap.set('n', '[[', function()
        move_problem(-1)
    end, { buf = opts.buf })

    vim.keymap.set('n', '<leader>w', function()
        vim.cmd.wall()
        vim.lsp.buf.format({ async = true })

        -- Compile
        vim.fn.jobstart(
            ('test -f %s && echo >%s; g++ @compile_flags.txt %s -o %s 2>%s'):format(
                output,
                output,
                filename,
                exename,
                output,
                output
            ),
            {
                on_exit = function()
                    -- Send stderr to output on failure
                    -- Configure timer
                    local job_stopped = false
                    local timer = vim.loop.new_timer()

                    -- Run the program on success
                    vim.schedule(function()
                        local job_id = vim.fn.jobstart(
                            ('%s < %s >>%s 2>&1 && rm %s'):format(
                                exename,
                                input,
                                output,
                                exename
                            ),
                            {
                                on_exit = function()
                                    if not job_stopped then
                                        timer:stop()
                                        timer:close()
                                        vim.api.nvim_buf_call(
                                            output_buf,
                                            function()
                                                vim.cmd('e!')
                                            end
                                        )
                                    end
                                end,
                            }
                        )

                        -- Enforce timeout (2s)
                        timer:start(2000, 0, function()
                            vim.schedule(function()
                                local line_count =
                                    vim.api.nvim_buf_line_count(output_buf)
                                if vim.fn.jobwait({ job_id }, 0)[1] == -1 then
                                    job_stopped = true
                                    vim.fn.jobstop(job_id)
                                    vim.api.nvim_buf_set_lines(
                                        output_buf,
                                        line_count,
                                        line_count,
                                        true,
                                        { 'TIMEOUT' }
                                    )
                                end

                                timer:stop()
                                timer:close()
                            end)
                        end)
                    end)
                end,
            }
        )
    end, { buf = opts.buf })
end, { nargs = 1 })
