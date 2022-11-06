local path = {
    value = function()
        local expanded = vim.fn.expand '%:p'
        local shrunk = expanded

        if vim.startswith(expanded, vim.env.HOME) then
            local path = require 'plenary.path'
            shrunk = path:new(vim.fn.expand '%:~'):shorten()
        end

        return shrunk
    end,
    highlight = 'Yellow',
}

return {
    [1] = path,
}
