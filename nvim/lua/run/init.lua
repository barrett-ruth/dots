local api, fn = vim.api, vim.fn
local aug
local bufs = {}

local utils = require 'run.utils'
local commands = utils.commands

local M = {}

local run = function()
    local extension = fn.expand '%:e'

    if not commands[extension] then return end

    local filename = fn.expand '%'
    local command = commands[extension]

    local header, jobcmd = utils.get_job_info(command, filename)

    bmap {
        'n',
        '<leader>bd',
        function()
            utils.delete_scratch_buffer(bufs[fn.bufnr()])

            require('mini.bufremove').delete(0, false)
        end,
    }

    api.nvim_create_autocmd('QuitPre', {
        callback = function() utils.delete_scratch_buffer(bufs[fn.bufnr()]) end,
        group = aug,
    })

    api.nvim_create_autocmd('BufWritePost', {
        pattern = filename,
        callback = function()
            local bufnr = fn.bufnr()
            local scratch_bufnr = bufs[bufnr]

            if not scratch_bufnr then
                scratch_bufnr = utils.create_scratch_buffer()
                bufs[bufnr] = scratch_bufnr
            end

            if fn.bufwinid(scratch_bufnr) == -1 then
                vim.cmd('vert sbuffer ' .. scratch_bufnr)
            end

            api.nvim_buf_set_lines(scratch_bufnr, 0, -1, false, { header, '' })

            local output_data =
                function(_, data) utils.output_data(_, data, scratch_bufnr) end

            local start_time = fn.reltime()

            local id = fn.jobstart(jobcmd, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = output_data,
                on_stderr = output_data,
                on_exit = function(_, exit_code, _)
                    utils.on_exit(exit_code, scratch_bufnr, start_time)
                end
            })

            vim.cmd.redraw()

            local status = fn.jobwait({ id })[1]

            -- Stopped with <c-c>
            if status == -2 then
                utils.on_exit(143, scratch_bufnr, start_time)
                fn.jobstart(command.kill)
            else
            end
        end,
        group = aug,
    })

    vim.cmd.w()
end

M.setup = function()
    aug = api.nvim_create_augroup('run', { clear = true })
    bufs = {}
    map { 'n', '<leader>r', run }
end

return M
