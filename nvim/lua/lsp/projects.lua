local M = {}

local aug = vim.api.nvim_create_augroup('projects', {})

M.projects = {
    theCourseForum2 = {
        lsp_sources = { 'autopep8' },
    },
    ['import-cost.nvim'] = {
        setup = function()
            vim.api.nvim_create_autocmd('BufWritePost', {
                pattern = 'index.js',
                command = 'sil !cp % import-cost/',
                group = aug,
            })
        end,
    },
}

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        local project = M.projects[project_name]

        if project and project.setup then
            project.setup()
        end
    end,
    group = aug,
})

return M
