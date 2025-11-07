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
                    ['ctrl-v'] = actions.file_vsplit,
                    ['ctrl-x'] = actions.file_split,
                    ['ctrl-h'] = actions.toggle_hidden,
                },
            },
            border = 'single',
            git = {
                files = {
                    cmd = 'git ls-files --cached --others --exclude-standard',
                    git_icons = false,
                },
                worktrees = {
                    actions = {
                        ['ctrl-d'] = {
                            fn = actions.git_worktree_del,
                            reload = true,
                        },
                        ['ctrl-x'] = {
                            fn = actions.git_worktree_add,
                            field_index = '{q}',
                            reload = true,
                        },
                        ['ctrl-a'] = false,
                    },
                },
                branches = {
                    actions = {
                        ['ctrl-d'] = {
                            fn = actions.git_branch_del,
                            reload = true,
                        },
                        ['ctrl-x'] = {
                            fn = actions.git_branch_add,
                            field_index = '{q}',
                            reload = true,
                        },
                        ['ctrl-a'] = false,
                    },
                },
            },
            buffers = {
                actions = {
                    ['ctrl-d'] = { actions.buf_del, actions.resume },
                },
            },
        })

        fzf.setup(opts)
    end,
    keys = {
        { '<c-b>', '<cmd>FzfLua buffers<cr>' },
        { '<c-f>', '<cmd>FzfLua files<cr>' },
        { '<c-g>', '<cmd>FzfLua live_grep<cr>' },
        { '<leader>gb', '<cmd>FzfLua git_worktrees<cr>' },
        { '<leader>gB', '<cmd>FzfLua git_branches<cr>' },
        { '<leader>ff', '<cmd>FzfLua files cwd=%:h<cr>' },
        { '<leader>fg', '<cmd>FzfLua live_grep cwd=%:h<cr>' },
        { '<leader>fh', '<cmd>FzfLua help_tags<cr>' },
        { '<leader>fH', '<cmd>FzfLua highlights<cr>' },
        { '<leader>fm', '<cmd>FzfLua man_pages<cr>' },
        { '<leader>fr', '<cmd>FzfLua resume<cr>' },
        { '<leader>fs', '<cmd>FzfLua files cwd=~/.local/bin/scripts<cr>' },
        { '<leader>fq', '<cmd>FzfLua quickfix' },
        { '<leader>fl', '<cmd>FzfLua loclist' },
        {
            '<leader>fe',
            function()
                require('fzf-lua').files({
                    cwd = '~/.config',
                })
            end,
        },
        { 'gw', '<cmd>FzfLua lsp_workspace_diagnostics<cr>' },
        { 'gW', '<cmd>FzfLua lsp_workspace_symbols<cr>' },
        { 'gO', '<cmd>FzfLua lsp_document_symbols<cr>' },
        { 'gd', '<cmd>FzfLua lsp_definitions<cr>' },
        { 'gD', '<cmd>FzfLua lsp_declarations<cr>' },
        { 'gq', '<cmd>FzfLua quickfix<cr>' },
        { 'gl', '<cmd>FzfLua loclist<cr>' },
        { 'gs', '<cmd>FzfLua lsp_typedefs<cr>' },
    },
    opts = {
        files = {
            cmd = vim.env.FZF_CTRL_T_COMMAND,
            git_icons = false,
            file_icons = false,
            no_header_i = true,
        },
        fzf_args = vim.env.FZF_DEFAULT_OPTS,
        grep = {
            git_icons = false,
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
