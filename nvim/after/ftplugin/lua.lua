map {
    'n',
    '<c-h>',
    function()
        vim.cmd.h(vim.fn.expand '<cword>')
    end,
}
