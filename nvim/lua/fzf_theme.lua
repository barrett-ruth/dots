local M = {}

function M.reload_colors()
    local theme_file = vim.fn.expand('~/.config/fzf/themes/theme')
    local lines = vim.fn.readfile(theme_file)
    if not lines or #lines == 0 then
        return
    end

    local content = table.concat(lines, '\n')

    local colors = {}
    for color_spec in content:gmatch('--color=([^%s]+)') do
        for key, value in color_spec:gmatch('([^:,]+):([^,]+)') do
            colors[key] = value
        end
    end

    require('fzf-lua').setup({ fzf_colors = colors })
end

return M
