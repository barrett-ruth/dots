return {
    {
        'echasnovski/mini.bracketed',
        config = function()
            require('mini.bracketed').setup {
                comment = { suffix = '/' },
                oldfile = { suffix = 'O' },
            }
        end,
    },
    {
        'echasnovski/mini.bufremove',
        config = function()
            local bufremove = require 'mini.bufremove'

            bufremove.setup {}

            map { 'n', '<leader>bd', bufremove.delete }
            map { 'n', '<leader>bw', bufremove.wipeout }
        end,
    },
    {
        'echasnovski/mini.ai',
        config = function()
            require('mini.ai').setup {
                custom_textobjects = {
                    e = function(ai_type)
                        local n_lines = vim.fn.line '$'
                        local start_line, end_line = 1, n_lines

                        if ai_type == 'i' then
                            local first_nonblank, last_nonblank =
                                vim.fn.nextnonblank(1),
                                vim.fn.prevnonblank(n_lines)
                            start_line = first_nonblank == 0 and 1
                                or first_nonblank
                            end_line = last_nonblank == 0 and n_lines
                                or last_nonblank
                        end

                        local to_col =
                            math.max(vim.fn.getline(end_line):len(), 1)

                        return {
                            from = { line = start_line, col = 1 },
                            to = { line = end_line, col = to_col },
                        }
                    end,
                },
            }
        end,
    },
    {
        'echasnovski/mini.splitjoin',
        config = function()
            require('mini.splitjoin').setup()
        end,
    },
}
