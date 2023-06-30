bmap({
    'n',
    'q',
    function()
        local ok, bufremove = pcall(require, 'mini.bufremove')
        if ok and not vim.fn.buflisted(0) then
            bufremove.delete()
        else
            vim.cmd.bw()
        end
    end,
})
