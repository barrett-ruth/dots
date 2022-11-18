local fn = vim.fn

local utils = require 'utils'

local search = {
    value = function()
        local count = fn.searchcount { maxcount = 999 }

        return ('%s [%s/%d]'):format(fn.getreg '/', count.current, count.total)
    end,
    condition = function()
        local status, searchcount = pcall(fn.searchcount)
        if not status then
            return false
        end

        return searchcount.total > 0
    end,
    highlight = 'White',
}

local file = {
    value = function()
        local file = fn.expand '%:f'

        if file:find(vim.env.HOME) then
            file = fn.expand '%:~'
        end

        return file
    end,
    highlight = 'Yellow',
}

local git = {
    value = function()
        return vim.b.gitsigns_head
    end,
    condition = function()
        return not utils.empty(vim.b.gitsigns_head)
    end,
    highlight = 'Orange',
}

local line = {
    value = '%l:%L',
    highlight = 'Blue',
}

local filetype = {
    value = function()
        local ft = vim.bo.filetype

        if utils.empty(ft) then
            ft = vim.bo.buftype
        end

        return ft
    end,
    condition = function()
        return not utils.empty(vim.bo.filetype)
            or not utils.empty(vim.bo.buftype)
    end,
    highlight = 'Purple',
}

local fileinfo = {
    value = function()
        return ('%s[%s]'):format(vim.bo.fileencoding, vim.bo.fileformat)
    end,
    highlight = 'Green',
}

return {
    left = {
        [1] = git,
        [2] = file,
    },
    right = {
        [1] = search,
        [2] = line,
        [3] = filetype,
        [4] = fileinfo,
    },
}
