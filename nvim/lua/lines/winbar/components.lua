local path = {
    value = function()
        local expanded = vim.fn.expand '%:p'
        local shrunk = expanded

        if vim.startswith(expanded, vim.env.HOME) then
            local fpath = require 'plenary.path'
            shrunk = fpath:new(vim.fn.expand '%:~'):shorten()
        end

        return shrunk
    end,
}

return {
    [1] = path,
}
