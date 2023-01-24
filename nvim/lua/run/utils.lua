local api, fn = vim.api, vim.fn

local M = {}

M.commands = {
    py = (vim.env.VIRTUAL_ENV or '/usr') .. '/bin/python',
    rs = {
        run = './a.exe',
        clean = 'test -f a.exe && rm a.exe',
        kill = 'rm a.exe && killall a.exe',
    },
    sh = 'sh',
    cpp = {
        build = 'g++ -Wall -Wextra -Wshadow -Wconversion -Wdouble-promotion -Wundef',
        run = './a.out',
        clean = 'test -f a.out && rm a.out',
        kill = 'rm a.out && killall a.out',
    },
    java = 'java',
}
M.commands.cc = M.commands.cpp

function M.show_scratch_buffer(scratch_bufnr)
    vim.cmd('vert sbuffer ' .. scratch_bufnr)
    api.nvim_win_set_option(fn.bufwinid(scratch_bufnr), 'number', false)
    api.nvim_win_set_option(fn.bufwinid(scratch_bufnr), 'relativenumber', false)
    api.nvim_win_set_option(fn.bufwinid(scratch_bufnr), 'signcolumn', 'yes')
end

function M.get_job_info(command, filename)
    local header, jobcmd = '', ''

    if command.build then
        jobcmd = ('%s %s && %s%s'):format(
            command.build,
            filename,
            command.run,
            command.clean and ('; ' .. command.clean) or ''
        )
        header = command.build
    else
        jobcmd = command .. ' ' .. filename
        header = command
    end

    header = ('> %s %s'):format(header, filename)

    return header, jobcmd
end

local exit_code_messages = {
    [0] = 'DONE',
    [143] = 'SIGKILL',
}

function M.on_exit(exit_code, scratch_bufnr, start_time)
    local end_time = fn.reltime(start_time)
    local total_time, units = tonumber(vim.trim(fn.reltimestr(end_time))), 's'

    if total_time < 1 then
        total_time, units = total_time * 1000, 'ms'
    end

    local msg = exit_code_messages[exit_code] or 'ERROR'

    if not api.nvim_buf_is_valid(scratch_bufnr) then
        return
    end

    api.nvim_buf_set_lines(scratch_bufnr, -1, -1, false, {
        ('[%s] exited with code=%s in %s%s'):format(
            msg,
            exit_code,
            total_time,
            units
        ),
    })
end

return M
