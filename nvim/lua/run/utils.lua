local api, fn = vim.api, vim.fn

local M = {}

M.commands = {
    py = (vim.env.VIRTUAL_ENV or '/usr') .. '/bin/python',
    sh = 'sh',
    cpp = {
        build = 'g++ -Wall -Wextra -Wshadow -Wconversion -Wdouble-promotion -Wundef',
        run = './a.out',
        clean = 'test -f a.out && rm a.out',
    },
}
M.commands.cc = M.commands.cpp

M.get_job_info = function(command, filename)
    local header, jobcmd = '', ''

    if command.build then
        jobcmd = ('%s %s && %s; %s'):format(
            command.build,
            filename,
            command.run,
            command.clean
        )
        header = command.build
    else
        jobcmd = command .. ' ' .. filename
        header = command
    end

    header = (' > %s %s'):format(header, filename)

    return header, jobcmd
end

M.on_exit = function(_, exit_code, scratch_bufnr, start_time)
    local end_time = fn.reltime(start_time)
    local total_time, units = tonumber(vim.trim(fn.reltimestr(end_time))), 's'

    if total_time < 1 then
        total_time, units = total_time * 1000, 'ms'
    end

    local msg = exit_code == 0 and 'DONE' or 'ERROR'

    api.nvim_buf_set_lines(scratch_bufnr, -1, -1, false, {
        '',
        ('[%s] exited with code=%s in %s%s'):format(
            msg,
            exit_code,
            total_time,
            units
        ),
    })
end

M.output_data = function(_, data, scratch_bufnr)
    if data[1] == '' then return end

    api.nvim_buf_set_lines(scratch_bufnr, -1, -1, false, data)
end

M.create_scratch_buffer = function()
    local scratch_bufnr = api.nvim_create_buf(false, true)

    api.nvim_buf_set_option(scratch_bufnr, 'filetype', 'run')

    return scratch_bufnr
end

M.delete_scratch_buffer =
    function() pcall(vim.cmd, 'BufDel! scratch' .. fn.bufnr()) end

return M
