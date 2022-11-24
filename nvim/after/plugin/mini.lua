require('mini.align').setup()

local fn = vim.fn

require('mini.ai').setup {
    custom_textobjects = {
        e = function(ai_type)
            local n_lines = fn.line '$'
            local start_line, end_line = 1, n_lines

            if ai_type == 'i' then
                local first_nonblank, last_nonblank =
                    fn.nextnonblank(1), fn.prevnonblank(n_lines)
                start_line = first_nonblank == 0 and 1 or first_nonblank
                end_line = last_nonblank == 0 and n_lines or last_nonblank
            end

            local to_col = math.max(fn.getline(end_line):len(), 1)

            return {
                from = { line = start_line, col = 1 },
                to = { line = end_line, col = to_col },
            }
        end,
    },
}
