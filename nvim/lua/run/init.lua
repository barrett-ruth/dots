local api, fn = vim.api, vim.fn
local aug

local utils = require 'run.utils'
local commands = utils.commands

local M = {}

-- Run file in corresponding output buffer on save
M.run = function()
    local extension = fn.expand '%:e'

    if not commands[extension] then return end

    local filename = fn.expand '%:p'
    local command = commands[extension] .. ' ' .. filename
    local header = ' > ' .. command:gsub(vim.env.HOME, '~')

    -- TODO: cleaner way to do this
    if vim.tbl_contains({ 'cc', 'cpp' }, extension) then
        command = command .. ' && ./a.out; test -f a.out && rm a.out'
    end

    api.nvim_create_autocmd('QuitPre', {
        callback = utils.delete_scratch_buffer,
        group = aug,
    })

    api.nvim_create_autocmd('BufWritePost', {
        pattern = filename,
        callback = function()
            local scratch_bufnr, scratch_name = utils.scratch_buffer_info()

            -- Create & split scratch buffer
            scratch_bufnr =
                utils.create_scratch_buffer(scratch_bufnr, scratch_name)

            -- Split if not open
            if fn.bufwinid(scratch_bufnr) == -1 then
                vim.cmd.vs(scratch_name)
            end

            api.nvim_buf_set_lines(scratch_bufnr, 0, -1, false, { header, '' })

            local output_data =
                function(_, data) utils.output_data(_, data, scratch_bufnr) end

            local start_time = fn.reltime()

            fn.jobstart(command, {
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
    require('utils').map { 'n', '<leader>r', M.run }
end

return M
