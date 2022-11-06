_G.map = function(mapping, opts)
    vim.keymap.set(
        mapping[1],
        mapping[2],
        mapping[3],
        vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
    )
end

_G.bmap = function(mapping, opts)
    map(mapping, vim.tbl_extend('force', opts or {}, { buffer = 0 }))
end

local cmd = vim.cmd

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

map({ 'n', ':', ';' }, { silent = false })
map({ 'n', ';', ':' }, { silent = false })
map({ 'x', ':', ';' }, { silent = false })
map({ 'x', ';', ':' }, { silent = false })

map { 'n', 'J', 'mzJ`z' }
map { 'v', 'J', [[:m '>+1<cr>gv=gv]] }
map { 'v', 'K', [[:m '<-2<cr>gv=gv]] }
map { 'n', 'Q', 'q:k' }

map { 'n', '<leader><cr>', cmd.source }
map { 'n', '<leader>-', 'S<esc>' }

map({ '', '<leader>y', '"+y' }, { silent = false })
map { '', '<leader>Y', function() vim.fn.setreg('+', vim.fn.getreg '"') end }
map { '', '<leader>p', '"_dP' }
map { 'n', '<leader>q', cmd.q }
map { 'n', '<leader>Q', function() vim.cmd 'qall!' end }
map {
    'n',
    '<leader>w',
    cmd.w,
    { silent = false },
}
map { 'n', '<leader>z', 'ZZ' }
map { 'n', '<leader>Z', cmd.wqall }

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
