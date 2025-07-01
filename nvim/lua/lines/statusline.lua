local empty = require('utils').empty

local M = {}

local file = {
    highlight = 'blue',
    value = function()
        return vim.fn.expand('%:~')
        -- return vim.fn.pathshorten(vim.fn.expand('%:~'))
        -- return vim.fn.fnamemodify(
        --     vim.fn.bufname(vim.api.nvim_get_current_buf()),
        --     ':~:.'
        -- )
    end,
}

local git = {
    highlight = 'magenta',
    value = function()
        return vim.b.gitsigns_head
    end,
    condition = function()
        return not empty(vim.b.gitsigns_head)
    end,
}

local modified = {
    value = function()
        return vim.api.nvim_get_option_value('modified', { buf = 0 }) and '+w'
            or ''
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
    highlight = 'green',
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
    highlight = 'yellow',
    value = '%c:%l/%L',
}

M.components = {
    left = {
        [1] = git,
        [2] = file,
        [3] = modified,
    },
    right = {
        -- [1] = search,
        [1] = lineinfo,
        [2] = filetype,
    },
}

local format_components = require('lines.utils').format_components

M.statusline = function()
    return ('%s%%=%s'):format(
        format_components(M.components.left),
        format_components(M.components.right)
    )
end

return M
