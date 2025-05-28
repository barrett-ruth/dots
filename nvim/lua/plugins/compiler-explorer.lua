return {
    'krady21/compiler-explorer.nvim',
    keys = {
        { 
            '<leader>c', 
            function()
                local cmd = {"CECompileLive", "compiler=g143"}
                if vim.fn.filereadable("compile_flags.txt") == 1 then
                    for line in io.lines("compile_flags.txt") do
                        if line ~= "" then
                            table.insert(cmd, "flags=" .. line)
                        end
                    end
                end
                vim.cmd(table.concat(cmd, " "))
            end
        },
    },
    opts = {
        line_match = {
            highlight = true,
            jump = true
        },
    }
}
