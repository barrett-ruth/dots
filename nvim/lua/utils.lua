local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.au(name, group_name, opts)
    opts.group = vim.api.nvim_create_augroup(group_name, { clear = true })
    vim.api.nvim_create_autocmd(name, opts)
end

return M
