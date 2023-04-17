local M = {}

local aug = vim.api.nvim_create_augroup('AProjects', {})

M.projects = {
    theCourseForum2 = {
        lsp_sources = { 'autopep8' },
        setup = function()
            require('gitsigns').toggle_current_line_blame { value = true }
        end,
    },
    ['import-cost.nvim'] = {
        auto_setup = true,
        setup = function()
            vim.api.nvim_create_autocmd('BufWritePost', {
                pattern = 'index.js',
                command = 'sil !cp % import-cost/',
                group = aug,
            })
        end,
    },
}

M.setup = function(manual_setup)
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    local project = M.projects[project_name]

    if project and project.setup and (project.auto_setup or manual_setup) then
        project.setup()
    end
end

return M
