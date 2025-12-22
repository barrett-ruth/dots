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

map({ { 'i', 'c' }, '<c-a>', '<esc>' })

for key, cmd in pairs({
    left = 'vertical resize -10',
    right = 'vertical resize +10',
    down = 'resize +10',
    up = 'resize -10',
}) do
    map({
        'n',
        ('<%s>'):format(key),
        function()
            vim.cmd(cmd)
        end,
    })
end

map({ 'n', 'J', 'mzJ`z' })

map({ 'x', 'p', '"_dp' })
map({ 'x', 'P', '"_dP' })
map({ 't', '<esc>', '<c-\\><c-n>' })

map({ 'n', '<leader>iw', '<cmd>se wrap!<cr>' })
map({ 'n', '<leader>is', '<cmd>se spell!<cr>' })
local state = nil

map({
    'n',
    '<leader>iz',
    function()
        if state then
            for k, v in pairs(state) do
                vim.opt[k] = v
            end
            state = nil
        else
            state = {
                number = vim.opt.number:get(),
                relativenumber = vim.opt.relativenumber:get(),
                signcolumn = vim.opt.signcolumn:get(),
                statuscolumn = vim.opt.statuscolumn:get(),
                laststatus = vim.opt.laststatus:get(),
                cmdheight = vim.opt.cmdheight:get(),
            }
            vim.opt.number = false
            vim.opt.relativenumber = false
            vim.opt.signcolumn = 'no'
            vim.opt.statuscolumn = ''
            vim.opt.laststatus = 0
            vim.opt.cmdheight = 0
        end
    end,
})
