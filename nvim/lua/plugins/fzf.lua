local fd_opts = vim.env.FZF_CTRL_T_COMMAND:match(' (.*)')

return {
    'ibhagwan/fzf-lua',
    config = function(_, opts)
        local actions, fzf = require('fzf-lua.actions'), require('fzf-lua')

        opts = vim.tbl_extend('keep', opts, {
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
                },
            },
            border = 'single',
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
        { '<c-f>', '<cmd>FzfLua files cwd_prompt=false<cr>' },
        { '<c-g>', '<cmd>FzfLua live_grep<cr>' },
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
                    fd_opts = ('%s --hidden'):format(fd_opts),
                })
            end,
        },
        { 'gw', '<cmd>FzfLua lsp_workspace_diagnostics<cr>' },
        { 'gsa', '<cmd>FzfLua lsp_document_symbols<cr>' },
        { 'gsc', '<cmd>FzfLua lsp_document_symbols regex_filter=Class.*<cr>' },
        {
            'gsf',
            function()
                require('fzf-lua').lsp_document_symbols({
                    regex_filter = function(entry)
                        return vim.tbl_contains(
                            { 'Function', 'Method' },
                            entry.kind
                        )
                    end,
                })
            end,
        },
        { 'gd', '<cmd>FzfLua lsp_definitions<cr>' },
        { 'gD', '<cmd>FzfLua lsp_declarations<cr>' },
        { 'gq', '<cmd>FzfLua quickfix<cr>' },
        { 'gl', '<cmd>FzfLua loclist<cr>' },
        { 'gI', '<cmd>FzfLua lsp_implementations<cr>' },
        { 'grr', '<cmd>FzfLua lsp_references<cr>' },
        { 'gt', '<cmd>FzfLua lsp_typedefs<cr>' },
    },
    opts = {
        files = {
            fd_opts = fd_opts,
            git_icons = false,
            file_icons = false,
            formatter = 'path.filename_first',
            no_header_i = true,
        },
        fzf_args = vim.env.FZF_DEFAULT_OPTS,
        grep = {
            git_icons = false,
            file_icons = false,
            formatter = 'path.filename_first',
            no_header_i = true,
            RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        },
        lsp = {
            includeDeclaration = false,
            jump_to_single_result = true,
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
