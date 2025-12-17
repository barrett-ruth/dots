---@type number|nil
local git_tab = nil

return {
    {
        'tpope/vim-fugitive',
        keys = {
            {
                desc = 'Toggle Fugitive Tab',
                '<c-g>',
                function()
                    if vim.b.gitsigns_head == nil then
                        vim.notify(
                            'Error: working directory does not belong to a Git repository',
                            vim.log.levels.ERROR
                        )
                        return
                    end
                    if git_tab and vim.api.nvim_tabpage_is_valid(git_tab) then
                        if vim.api.nvim_get_current_tabpage() ~= git_tab then
                            vim.api.nvim_set_current_tabpage(git_tab)
                            return
                        end
                        vim.cmd.tabclose()
                        git_tab = nil
                        return
                    end
                    vim.cmd.tablast()
                    vim.cmd.tabnew()
                    vim.cmd.Git()
                    vim.cmd('silent only')
                    git_tab = vim.api.nvim_get_current_tabpage()
                end,
            },
        },
    },
    {
        'folke/snacks.nvim',
        ---@type snacks.Config
        opts = { gitbrowse = {} },
        keys = {
            { '<leader>go', '<cmd>lua Snacks.gitbrowse()<cr>' },
            { '<leader>gi', '<cmd>lua Snacks.picker.gh_issue()<cr>' },
            { '<leader>gp', '<cmd>lua Snacks.picker.gh_pr()<cr>' },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        keys = {
            { '[g', '<cmd>Gitsigns next_hunk<cr>' },
            { ']g', '<cmd>Gitsigns prev_hunk<cr>' },
        },
        event = 'VeryLazy',
        opts = {
            on_attach = function()
                vim.wo.signcolumn = 'yes'
            end,
            current_line_blame_formatter_nc = function()
                return {}
            end,
            attach_to_untracked = false,
            signcolumn = false,
            signs = {
                -- use boxdraw chars
                add = { text = '│' },
                change = { text = '│' },
                delete = { text = '＿' },
                topdelete = { text = '‾' },
                changedelete = { text = '│' },
            },
            current_line_blame = true,
        },
    },
}
