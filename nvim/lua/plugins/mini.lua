return {
    {
        'echasnovski/mini.ai',
        opts = {
            custom_textobjects = {
                e = function(ai_type)
                    local n_lines = vim.fn.line('$')
                    local start_line, end_line = 1, n_lines

                    if ai_type == 'i' then
                        local first_nonblank, last_nonblank =
                            vim.fn.nextnonblank(1), vim.fn.prevnonblank(n_lines)
                        start_line = first_nonblank == 0 and 1 or first_nonblank
                        end_line = last_nonblank == 0 and n_lines
                            or last_nonblank
                    end

                    local to_col = math.max(vim.fn.getline(end_line):len(), 1)

                    return {
                        from = { line = start_line, col = 1 },
                        to = { line = end_line, col = to_col },
                    }
                end,
            },
        },
        event = 'VeryLazy',
    },
    {
        'echasnovski/mini.bracketed',
        opts = {
            undo = { suffix = '' },
            redo = { suffix = '' },
            comment = { suffix = '/' },
            oldfile = { suffix = ' ' },
        },
        event = 'VeryLazy',
    },
    {
        'echasnovski/mini.bufremove',
        config = true,
        keys = {
            { '<leader>bd', '<cmd>lua require("mini.bufremove").delete()<cr>' },
            {
                '<leader>bw',
                '<cmd>lua require("mini.bufremove").wipeout()<cr>',
            },
        },
    },
    {
        'echasnovski/mini.comment',
        dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
        event = 'VeryLazy',
        opts = {
            options = {
                custom_commentstring = function()
                    return require('ts_context_commentstring.internal').calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
            mappings = { comment_line = 'g/' },
        },
    },
    {
        'echasnovski/mini.operators',
        opts = {
            replace = {
                prefix = 'gl',
            },
        },
        event = 'VeryLazy',
    },
    {
        'echasnovski/mini.pairs',
        config = true,
        event = 'InsertEnter',
    },
}
