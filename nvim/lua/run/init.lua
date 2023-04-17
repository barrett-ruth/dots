local api, fn = vim.api, vim.fn
local aug, cache

local utils = require 'run.utils'
local commands = utils.commands

local M = {}

local run = function()
    local extension = fn.expand '%:e'

    if not commands[extension] then
        return
    end

    local filename = fn.expand '%'
    local command = commands[extension]

    local header, jobcmd = utils.get_job_info(command, filename)

    local bufnr = api.nvim_get_current_buf()

    bmap {
        'n',
        '<leader>bd',
        function()
            utils.delete_buffer(bufnr, cache, false)
        end,
    }
    bmap {
        'n',
        '<leader>bw',
        function()
            utils.delete_buffer(bufnr, cache, true)
        end,
    }

    bmap {
        'n',
        '<c-c>',
        function()
            if not cache[bufnr] then
                return
            end

            local id = cache[bufnr].job_id

            if not id then
                return
            end

            fn.jobstop(id)
            cache[bufnr].job_id = nil

            if command.kill then
                fn.jobstart(command.kill)
            end
        end,
    }

    api.nvim_create_autocmd('QuitPre', {
        pattern = '<buffer>',
        callback = function()
            vim.cmd.bw(cache[bufnr].bufnr)
            cache[bufnr] = nil
        end,
        group = aug,
    })

    api.nvim_create_autocmd('BufWritePost', {
        pattern = '<buffer>',
        callback = function()
            local scratch_bufnr
            if cache[bufnr] then
                scratch_bufnr = cache[bufnr].bufnr
            end

            if not scratch_bufnr then
                scratch_bufnr = api.nvim_create_buf(false, true)
                api.nvim_buf_set_option(scratch_bufnr, 'filetype', 'run')
                cache[bufnr] = { bufnr = scratch_bufnr }
            end

            if fn.bufwinid(scratch_bufnr) == -1 then
                utils.show_scratch_buffer(scratch_bufnr)
            end

            api.nvim_buf_set_lines(scratch_bufnr, 0, -1, false, { header, '' })

            local function output_data(_, data)
                api.nvim_buf_set_lines(scratch_bufnr, -1, -1, false, data)
            end

            local start_time = fn.reltime()

            local id = fn.jobstart(jobcmd, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = output_data,
                on_stderr = output_data,
                on_exit = function(_, exit_code, _)
                    utils.on_exit(exit_code, scratch_bufnr, start_time)

                    cache[bufnr].job_id = nil
                end,
            })

            cache[bufnr].job_id = id
        end,
        group = aug,
    })

    vim.cmd.w()
end

M.setup = function()
    aug = api.nvim_create_augroup('ARun', {})
    -- [bufnr] -> { bufnr: scratch_bufnr, job_id: job_id }
    cache = {}
    map { 'n', '<leader>r', run }
end

return M
