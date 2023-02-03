function _G.map(mapping, opts)
    vim.keymap.set(
        mapping[1],
        mapping[2],
        mapping[3],
        vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
    )
end

function _G.bmap(mapping, opts)
    map(mapping, vim.tbl_extend('keep', opts or {}, { buffer = 0 }))
end

map {
    'n',
    'gx',
    function()
        local url = vim.fn.expand('<cfile>', nil)

        if not url:match 'https' and url:match '/' then
            url = 'https://github.com/' .. url
        end

        vim.fn.jobstart { vim.env.BROWSER, '--new-window', url }
    end,
}

map { 'n', '<up>', '<cmd>resize -5<cr>' }
map { 'n', '<down>', '<cmd>resize +5<cr>' }
map { 'n', '<left>', '<cmd>vert resize +5<cr>' }
map { 'n', '<right>', '<cmd>vert resize -5<cr>' }

map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })

map { 'n', 'J', 'mzJ`z' }

map {
    'n',
    '<leader>Y',
    function()
        vim.fn.setreg('+', vim.fn.getreg '0')
    end,
}

local cmd = vim.cmd

map { 'n', ']b', cmd.bnext }
map { 'n', '[b', cmd.bprev }

map { 'n', ']l', cmd.lnext }
map { 'n', '[l', cmd.lprev }

map { 'n', '[o', '@="m`O\\eg``"<cr>' }
map { 'n', ']o', '@="m`o\\eg``"<cr>' }

map { 'n', ']q', cmd.cnext }
map { 'n', '[q', cmd.cprev }

map { 'n', ']z', 'zj' }
map { 'n', ']Z', ']z' }
map { 'n', '[z', 'zk[z' }
map { 'n', '[Z', '[z' }

map { 'x', 'p', '"_dp' }
map { 'x', 'P', '"_dP' }
