local function empty(s)
    return s == nil or s == ''
end

local file = {
    value = function()
        return vim.fn.bufname(vim.api.nvim_get_current_buf())
    end,
}

local git = {
    value = function()
        return vim.b.gitsigns_head
    end,
    condition = function()
        return not empty(vim.b.gitsigns_head)
    end,
}

local search = {
    value = function()
        local count = vim.fn.searchcount({ maxcount = 999 })

        return string.format(
            '%s [%s/%d]',
            vim.fn.getreg('/'),
            count.current,
            count.total
        )
    end,
    condition = function()
        local status, searchcount = pcall(vim.fn.searchcount)

        if not status or not searchcount or vim.tbl_isempty(searchcount) then
            return false
        end

        return searchcount.total > 0
    end,
}

local filetype = {
    value = function()
        local ft = vim.api.nvim_get_option_value(
            'filetype',
            { buf = vim.api.nvim_get_current_buf() }
        )

        if empty(ft) then
            ft = vim.bo.buftype
        end

        return ft
    end,
    condition = function()
        local ft = vim.api.nvim_get_option_value(
            'filetype',
            { buf = vim.api.nvim_get_current_buf() }
        )

        return not empty(ft) or not empty(vim.bo.buftype)
    end,
}

local lineinfo = {
    value = '%c:%l/%L',
}

local statusline = {
    left = {
        [1] = git,
        [2] = file,
    },
    right = {
        [1] = search,
        [2] = lineinfo,
        [3] = filetype,
    },
}

local format_components = require('lines.utils').format_components

return {
    statusline = function()
        return ('%s%%=%s'):format(
            format_components(statusline.left),
            format_components(statusline.right)
        )
    end,
}
