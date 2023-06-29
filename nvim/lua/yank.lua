local preserve_cursor = {}

local function on_yank()
    if preserve_cursor then
        vim.fn.setpos('.', preserve_cursor.cursor_position or vim.empty_dict())
        vim.fn.winrestview(preserve_cursor.win_state or vim.empty_dict())

        preserve_cursor = {}
    end
end

local function yank()
    preserve_cursor = {
        cursor_position = vim.fn.getpos('.'),
        win_state = vim.fn.winsaveview(),
    }

    vim.api.nvim_buf_attach(0, false, {
        on_lines = function()
            preserve_cursor = {}

            return true
        end,
    })

    return 'y'
end

return {
    setup = function()
        map({ { 'n', 'x' }, 'y', yank }, { expr = true, silent = true })

        vim.api.nvim_create_autocmd('TextYankPost', {
            callback = function()
                on_yank()
                vim.highlight.on_yank({
                    higroup = 'RedrawDebugNormal',
                    timeout = '300',
                })
            end,
            group = vim.api.nvim_create_augroup('AYank', {}),
        })
    end,
}
