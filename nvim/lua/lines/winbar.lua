local path = {
    value = function()
        local expanded = vim.fn.expand '%:p'
        local shrunk = expanded

        local fpath = require 'plenary.path'
        shrunk = fpath:new(vim.fn.expand '%:~'):shorten()

        return shrunk
    end,
}

return {
    [1] = path,
}
