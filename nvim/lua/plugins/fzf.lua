local fd_opts = vim.env.FZF_CTRL_T_COMMAND:match(' (.*)')

local send_to_ll = function(selected, opts)
    local ll = {}
    for i = 1, #selected do
        local file = require('fzf-lua.path').entry_to_file(selected[i], opts)
        local text = selected[i]:match(':%d+:%d?%d?%d?%d?:?(.*)$')
        ll[#ll + 1] = {
            filename = file.path,
            lnum = file.line,
            col = file.col,
            text = text,
        }
    end

    vim.fn.setloclist(0, ll)
    vim.cmd.lclose()
end

return {
    'ibhagwan/fzf-lua',
    config = function(_, opts)
        local actions, fzf = require('fzf-lua.actions'), require('fzf-lua')
        opts = vim.tbl_extend('keep', opts, {
            actions = {
                files = {
                    ['default'] = actions.file_edit,
                    ['ctrl-h'] = {
                        function(_, args)
                            if args.cmd:find('--hidden') then
                                args.cmd = args.cmd:gsub('--hidden', '', 1)
                            else
                                args.cmd = args.cmd .. ' --hidden'
                            end
                            fzf.files(args)
                        end,
                    },
                    ['ctrl-l'] = send_to_ll,
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
        { '<c-g>', '<cmd>FzfLua live_grep_native<cr>' },
        { '<leader>gb', '<cmd>FzfLua git_branches<cr>' },
        { '<leader>ff', '<cmd>FzfLua files cwd=%:h<cr>' },
        { '<leader>fg', '<cmd>FzfLua live_grep_native cwd=%:h<cr>' },
        { '<leader>fh', '<cmd>FzfLua help_tags<cr>' },
        { '<leader>fH', '<cmd>FzfLua highlights<cr>' },
        { '<leader>fm', '<cmd>FzfLua man_pages<cr>' },
        { '<leader>fr', '<cmd>FzfLua resume<cr>' },
        { '<leader>fs', '<cmd>FzfLua files cwd=~/.local/bin/scripts<cr>' },
        {
            '<leader>fe',
            function()
                require('fzf-lua').files({
                    cwd = '~/.config',
                    fd_opts = fd_opts .. ' --hidden',
                })
            end,
        },
        { 'gw', '<cmd>FzfLua lsp_workspace_diagnostics<cr>' },
        { 'gsa', '<cmd>FzfLua lsp_document_symbols<cr>' },
        { 'gsc', '<cmd>FzfLua lsp_document_symbols regex_filter=Class.*<cr>' },
        {
            'gsf',
            '<cmd>FzfLua lsp_document_symbols regex_filter=Function.*<cr>',
        },
        { 'gd', '<cmd>FzfLua lsp_definitions<cr>' },
        { 'gD', '<cmd>FzfLua lsp_declarations<cr>' },
        { 'gI', '<cmd>FzfLua lsp_implementations<cr>' },
        { 'gR', '<cmd>FzfLua lsp_references<cr>' },
        { 'gt', '<cmd>FzfLua lsp_typedefs<cr>' },
    },
    opts = {
        debug = true,
        global_resume = true,
        global_resume_query = true,
        files = {
            fd_opts = fd_opts,
            git_icons = false,
            file_icons = false,
        },
        fzf_args = vim.env.FZF_DEFAULT_OPTS,
        grep = {
            no_header_i = true,
        },
        loclist = {
            path_shorten = true,
        },
        lsp = {
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
        diagnostics = {
            file_icons = false,
        },
        quickfix = {
            path_shorten = true,
        },
    },
}
