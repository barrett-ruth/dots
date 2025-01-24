local function clearcol()
    vim.api.nvim_set_option_value('number', false, { scope = 'local' })
    vim.api.nvim_set_option_value('relativenumber', false, { scope = 'local' })
    vim.api.nvim_set_option_value('statuscolumn', ' ', { scope = 'local' })
    vim.api.nvim_set_option_value('equalalways', false, { scope = 'global' })
end

local types = { 'usaco', 'cf' }

local M = { _enabled = {}, last = {}, time = {} }

function M.setup()
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

        local id = vim.fn.expand('%')

        -- Configure statusline support
        if not M._enabled[id] then
            M._enabled[id] = true
            M.last[id] = os.time()
            M.time[id] = 0
            vim.api.nvim_create_autocmd('BufWinEnter', {
                pattern = '<buffer>',
                callback = function()
                    M.last[id] = os.time()
                end,
            })
        end

        -- Disable LSP
        if vim.diagnostic.is_enabled({ bufnr = 0 }) then
            vim.diagnostic.enable(false, { bufnr = 0 })
        end

        -- Populate coding buffer
        if vim.api.nvim_buf_get_lines(0, 0, -1, true)[1] == '' then
            vim.api.nvim_input('i' .. type_ .. '<c-s>')
        end

        -- Configure windows
        local filename = vim.fn.expand('%')
        local base_filepath = vim.fn.fnamemodify(filename, ':p:r')
        local input, output = base_filepath .. '.in', base_filepath .. '.out'

        vim.cmd('50vsplit ' .. output)
        local output_buf = vim.api.nvim_get_current_buf()
        vim.cmd.w()
        clearcol()
        vim.cmd.split(input)
        local input_buf = vim.api.nvim_get_current_buf()
        vim.cmd.w()
        clearcol()
        vim.cmd.wincmd('h')
        vim.cmd('vertical resize +8')

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
        end, { buffer = true })
        vim.keymap.set('n', '[[', function()
            move_problem(-1)
        end, { buffer = true })

        vim.api.nvim_create_autocmd('BufWritePost', {
            pattern = input,
            callback = function()
                vim.cmd.w()
                vim.fn.jobstart({ 'CP', 'run', filename }, {
                    on_exit = function()
                        vim.cmd.checktime()
                    end,
                })
            end,
        })

        vim.keymap.set('n', '<leader>w', function()
            vim.cmd.w()
            vim.lsp.buf.format({ async = true })
            vim.fn.jobstart({ 'CP', 'run', filename }, {
                on_exit = function()
                    vim.cmd.checktime()
                end,
            })
        end, { buffer = true })

        vim.keymap.set('n', '<leader>d', function()
            vim.cmd.w()
            vim.lsp.buf.format({ async = true })
            vim.fn.jobstart({ 'CP', 'debug', filename }, {
                on_exit = function()
                    vim.cmd.checktime()
                end,
            })
        end, { buffer = true })
    end, { nargs = 1 })
end

function M.enabled()
    return M._enabled[vim.fn.expand('%')] or false
end

function M.render()
    local id = vim.fn.expand('%')
    local time = os.time()
    local elapsed = time - M.last[id]
    M.time[id] = M.time[id] + elapsed
    M.last[id] = time
    return ('[%s]'):format(os.date('%M:%S', M.time[id]))
end

return M
