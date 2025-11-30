return {
    'ibhagwan/fzf-lua',
    config = function(_, opts)
        local actions, fzf = require('fzf-lua.actions'), require('fzf-lua')

        opts = vim.tbl_extend('force', opts, {
            actions = {
                files = {
                    default = actions.file_edit,
                    ['ctrl-l'] = function(...)
                        actions.file_sel_to_ll(...)
                        vim.cmd.lclose()
                    end,
                    ['ctrl-q'] = function(...)
                        actions.file_sel_to_qf(...)
                        vim.cmd.cclose()
                    end,
                    ['ctrl-h'] = actions.toggle_hidden,
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-x'] = actions.file_split,
                },
            },
            border = 'single',
            git = {
                files = {
                    cmd = 'git ls-files --cached --others --exclude-standard',
                },
                worktrees = {
                    fzf_args = (
                        vim.env.FZF_DEFAULT_OPTS:gsub(
                            '--bind=ctrl-a:select-all',
                            ''
                        )
                    ),
                },
                branches = {
                    fzf_args = (
                        vim.env.FZF_DEFAULT_OPTS:gsub(
                            '--bind=ctrl-a:select-all',
                            ''
                        )
                    ),
                },
            },
        })

        fzf.setup(opts)

        require('fzf_theme').reload_colors()
    end,
    keys = {
        {
            '<c-t>',
            function()
                local fzf = require('fzf-lua')
                local git_dir = vim.fn
                    .system('git rev-parse --git-dir 2>/dev/null')
                    :gsub('\n', '')
                if vim.v.shell_error == 0 and git_dir ~= '' then
                    fzf.git_files({ cwd_prompt = false })
                else
                    fzf.files()
                end
            end,
        },
        { '<c-g>', '<cmd>FzfLua live_grep<cr>' },
        { '<leader>f/', '<cmd>FzfLua search_history<cr>' },
        { '<leader>f:', '<cmd>FzfLua command_history<cr>' },
        { '<leader>fa', '<cmd>FzfLua autocmds<cr>' },
        { '<leader>fB', '<cmd>FzfLua builtin<cr>' },
        { '<leader>fb', '<cmd>FzfLua buffers<cr>' },
        { '<leader>fc', '<cmd>FzfLua commands<cr>' },
        {
            '<leader>fe',
            '<cmd>FzfLua files cwd=~/.config<cr>',
        },
        {
            '<leader>ff',
            function()
                require('fzf-lua').files({ cwd = vim.fn.expand('%:h') })
            end,
        },
        {
            '<leader>fg',
            function()
                require('fzf-lua').live_grep({ cwd = vim.fn.expand('%:h') })
            end,
        },
        { '<leader>fH', '<cmd>FzfLua highlights<cr>' },
        { '<leader>fh', '<cmd>FzfLua help_tags<cr>' },
        { '<leader>fl', '<cmd>FzfLua loclist<cr>' },
        { '<leader>fm', '<cmd>FzfLua man_pages<cr>' },
        { '<leader>fq', '<cmd>FzfLua quickfix<cr>' },
        { '<leader>fr', '<cmd>FzfLua resume<cr>' },
        {
            '<leader>fs',
            '<cmd>FzfLua files cwd=~/.local/bin/scripts<cr>',
        },
        { '<leader>gB', '<cmd>FzfLua git_branches<cr>' },
        { '<leader>gb', '<cmd>FzfLua git_worktrees<cr>' },
        { 'gq', '<cmd>FzfLua quickfix<cr>' },
        { 'gl', '<cmd>FzfLua loclist<cr>' },
    },
    opts = {
        files = {
            cmd = vim.env.FZF_CTRL_T_COMMAND,
            file_icons = false,
            no_header_i = true,
        },
        fzf_args = vim.env.FZF_DEFAULT_OPTS,
        grep = {
            file_icons = false,
            no_header_i = true,
            RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        },
        lsp = {
            includeDeclaration = false,
            jump1 = true,
            symbols = {
                symbol_hl_prefix = '@',
                symbol_style = 3,
            },
        },
        winopts = {
            border = 'single',
            preview = {
                hidden = 'hidden',
            },
        },
    },
}
