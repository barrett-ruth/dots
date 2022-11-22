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
}

local file = {
    value = function()
        local fname = fn.expand '%:f'

        if fname:find(vim.env.HOME) then
            fname = fn.expand '%:~'
        end

        return fname
    end,
}

local git = {
    value = function()
        return vim.b.gitsigns_head
    end,
    condition = function()
        return not utils.empty(vim.b.gitsigns_head)
    end,
}

local line = {
    value = '%l:%L',
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
}

local fileinfo = {
    value = function()
        return ('%s[%s]'):format(vim.bo.fileencoding, vim.bo.fileformat)
    end,
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
