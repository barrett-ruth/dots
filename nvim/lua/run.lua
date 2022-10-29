local api, fn, env = vim.api, vim.fn, vim.env

local compile_c =
    '-Wall -Wextra -Wshadow -Wconversion -Wdouble-promotion -Wundef'
local commands = {
    py = env.VIRTUAL_ENV and env.VIRTUAL_ENV .. '/bin/python' or 'python',
    sh = 'sh',
    c = 'gcc ' .. compile_c,
    cpp = 'g++ ' .. compile_c,
}
commands.cc = commands.cpp

local M = {}

-- Run file in corresponding output buffer on save
M.run = function()
    local extension = fn.expand '%:e'

    if not commands[extension] then return end

    local filename = fn.expand '%:p'
    local command = commands[extension] .. ' ' .. filename
    local header = ' > ' .. command:gsub(env.HOME, '~')

    if vim.tbl_contains({ 'c', 'cc', 'cpp' }, extension) then
        command = command .. ' && ./a.out; test -f a.out && rm a.out'
    end

    api.nvim_create_autocmd('BufWritePost', {
        group = api.nvim_create_augroup('run', { clear = true }),
        pattern = filename,
        callback = function()
            local bufnr = fn.bufnr()
            local scratch_name = 'scratch' .. bufnr
            local scratch_bufnr = fn.bufnr(scratch_name)

            if scratch_bufnr == -1 then
                scratch_bufnr = api.nvim_create_buf(false, true)
                api.nvim_buf_set_name(scratch_bufnr, scratch_name)
            end

            if fn.bufwinid(scratch_bufnr) == -1 then
                vim.cmd.vs(scratch_name)
            end

            api.nvim_buf_set_lines(scratch_bufnr, 0, -1, false, { header, '' })

            local output_data = function(_, data)
                if data[1] ~= '' then
                    for k, v in ipairs(data) do
                        data[k] = v:gsub(env.HOME, '~')
                    end

                    api.nvim_buf_set_lines(scratch_bufnr, -1, -1, false, data)
                end
            end

            fn.jobstart(command, {
                stdout_buffered = true,
                stderr_buffered = true,
                on_stdout = output_data,
                on_stderr = output_data,
            })
        end,
    })

    vim.cmd.w()
end

M.setup = function() require('utils').map { 'n', '<leader>r', M.run } end

return M
