function _G.map(mapping, opts)
    vim.keymap.set(
        mapping[1],
        mapping[2],
        mapping[3],
        vim.tbl_extend('keep', opts or {}, { silent = true })
    )
end

function _G.bmap(mapping, opts)
    _G.map(mapping, vim.tbl_extend('force', opts or {}, { buffer = 0 }))
end

map({
    'n',
    'gx',
    function()
        local url = vim.fn.expand('<cfile>', nil)

        if not url:match('https') and url:match('/') then
            url = 'https://github.com/' .. url
        end

        vim.fn.jobstart({ vim.env.BROWSER, url })
    end,
})

map({ 'n', '<up>', '<cmd>resize -5<cr>' })
map({ 'n', '<down>', '<cmd>resize +5<cr>' })
map({ 'n', '<left>', '<cmd>vert resize +5<cr>' })
map({ 'n', '<right>', '<cmd>vert resize -5<cr>' })

map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })

map({ { 'i', 'c' }, '<c-a>', '<esc>' })

map({
    'n',
    '<leader>r',
    function()
        vim.cmd('sil !mux file %')
    end,
})

map({ 'n', 'J', 'mzJ`z' })

map({ 'n', '<leader>w', vim.cmd.w })
map({
    'n',
    '<leader>y',
    '<cmd>call setreg("+", getreg("0"))<cr>',
})

map({ 'n', '[o', '@="m`O\\eg``"<cr>' })
map({ 'n', ']o', '@="m`o\\eg``"<cr>' })

map({ 'x', 'p', '"_dp' })
map({ 'x', 'P', '"_dP' })
