bmap({
    'n',
    'q',
    function()
        local ok, bufremove = pcall(require, 'mini.bufremove')
        if ok then
            bufremove.delete()
        else
            vim.cmd.bw()
        end
    end,
})
