local fn = vim.fn

local utils = require 'utils'

local file = {
    value = function()
        return fn.expand '%:~:.'
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
        [1] = line,
        [2] = filetype,
        [3] = fileinfo,
    },
}
