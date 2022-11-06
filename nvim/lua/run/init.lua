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

    local header, jobcmd = utils.get_job_info(commands[extension], filename)

    api.nvim_create_autocmd('QuitPre', {
        callback = utils.delete_scratch_buffer,
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

            fn.jobstart(jobcmd, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = output_data,
                on_stderr = output_data,
                on_exit = function(_, exit_code)
                    utils.on_exit(_, exit_code, scratch_bufnr, start_time)
                end,
            })
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
