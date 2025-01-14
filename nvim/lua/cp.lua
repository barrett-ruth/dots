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

    -- Update compile flags
    -- Do this first so LSP reads & configures
    vim.fn.system(
        ('test -f compile_flags.txt || echo "%s" >compile_flags.txt'):format(
            compile_flags
        )
    )

    -- vim.diagnostic.enable(false)

    -- Populate coding buffer if empty
    if vim.api.nvim_buf_get_lines(0, 0, -1, true)[1] == '' then
        vim.api.nvim_input('i' .. type_ .. '<c-s>')
    end

    -- Configure window
    local filename = vim.fn.expand('%')
    local base_filename = vim.fn.expand('%:p:r')
    local exename = vim.trim(vim.fn.system('mktemp'))
    local input, output = base_filename .. '.in', base_filename .. '.out'

    vim.cmd('50vsplit ' .. output)
    vim.cmd.w()
    clearcol()
    vim.cmd.split(input)
    vim.cmd.w()
    clearcol()
    vim.cmd.wincmd('h')
    vim.cmd('vertical resize +8')

    local output_buf = find_buf(output)

    vim.api.nvim_create_autocmd('BufWritePost', {
        buffer = vim.api.nvim_get_current_buf(),
        callback = function()
            vim.lsp.buf.format({ async = true })

            -- Compile
            vim.system(
                { 'g++', '@compile_flags.txt', filename, '-o', exename },
                {},
                function(obj)
                    -- Send stderr to output on failure
                    if obj.code ~= 0 then
                        vim.schedule(function()
                            vim.api.nvim_buf_set_lines(
                                output_buf,
                                0,
                                -1,
                                true,
                                vim.split(
                                    obj.stderr,
                                    '\n',
                                    { trimempty = true }
                                )
                            )
                        end)
                    else
                        -- Configure timer
                        local job_stopped = false
                        local timer = vim.loop.new_timer()

                        -- Run the program on success
                        vim.schedule(function()
                            local job_id = vim.fn.jobstart(
                                ('%s < %s > %s && rm %s'):format(
                                    exename,
                                    input,
                                    output,
                                    exename
                                ),({
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
                                })
                            )

                            -- Enforce timeout (2s)
                            timer:start(2000, 0, function()
                                vim.schedule(function()
                                    if
                                        vim.fn.jobwait({ job_id }, 0)[1] == -1
                                    then
                                        job_stopped = true
                                        vim.fn.jobstop(job_id)
                                        vim.api.nvim_buf_set_lines(
                                            output_buf,
                                            0,
                                            -1,
                                            true,
                                            { 'TIMEOUT' }
                                        )
                                    end

                                    timer:stop()
                                    timer:close()
                                end)
                            end)
                        end)
                    end
                end
            )
        end,
    })
end, { nargs = 1 })
