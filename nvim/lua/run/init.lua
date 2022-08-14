local compile_c =
    '-Wall -Wextra -Wshadow -Wconversion -Wdouble-promotion -Wundef'
local commands = {
    py = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. '/bin/python'
        or 'python',
    sh = 'sh',
    c = 'gcc ' .. compile_c,
    cc = 'g++ ' .. compile_c,
}

local M = {}

M.run = function()
    local extension = vim.fn.expand '%:e'

    if not commands[extension] then return end

    local filename = vim.fn.expand '%:p'
    local command = commands[extension] .. ' ' .. filename
    local header = string.gsub(' > ' .. command, vim.env.HOME, '~')

    if extension == 'c' or extension == 'cc' then
        command = "trap 'rm a.out' 1 2; "
            .. command
            .. ' && ./a.out && rm a.out'
    end

    vim.api.nvim_create_autocmd('BufWritePost', {
        group = vim.api.nvim_create_augroup('run', { clear = true }),
        pattern = filename,
        callback = function()
            local scratch_bufnr = vim.fn.bufnr 'scratch'

            if scratch_bufnr == -1 then
                scratch_bufnr = vim.api.nvim_create_buf(false, true)
                vim.api.nvim_buf_set_name(scratch_bufnr, 'scratch')
            end

            if vim.fn.bufwinid(scratch_bufnr) == -1 then
                vim.cmd 'vs scratch'
            end

            vim.api.nvim_buf_set_lines(
                scratch_bufnr,
                0,
                -1,
                false,
                { header, '' }
            )

            local output_data = function(_, data)
                if data[1] ~= '' then
                    vim.api.nvim_buf_set_lines(
                        scratch_bufnr,
                        -1,
                        -1,
                        false,
                        data
                    )
                end
            end

            vim.fn.jobstart(command, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = output_data,
                on_stderr = output_data,
            })
        end,
    })
end

M.setup = function()
    local utils = require 'utils'
    utils.map {
        'n',
        '<leader>r',
        utils.mapstr('utils', 'format()')
            .. utils.mapstr('run', 'run()')
            .. utils.mapstr 'w',
    }
end

return M