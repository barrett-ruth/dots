local M = {}

_G.pr = function(...) vim.pretty_print(...) end

M.vorfn = function(val_or_fn)
    if type(val_or_fn) == 'function' then return val_or_fn() end

    return val_or_fn
end

M.empty = function(s) return s == '' or s == nil end

M.rename = function()
    local old_name = vim.fn.expand '<cword>'
    local api = vim.api

    local bufnr = api.nvim_create_buf(false, true)
    local win = api.nvim_open_win(bufnr, true, {
        style = 'minimal',
        border = 'single',
        relative = 'cursor',
        row = 1,
        col = -1,
        width = math.floor(old_name:len() > 20 and old_name:len() * 1.5 or 20),
        height = 1,
    })

    vim.wo.cursorline = false
    api.nvim_buf_set_lines(bufnr, 0, -1, true, { old_name })

    M.bmap({ 'i', '<c-c>', M.mapstr 'q' }, { buffer = bufnr })
    M.bmap({ 'n', 'q', M.mapstr 'q' }, { buffer = bufnr })
    M.bmap {
        { 'i', 'n' },
        '<cr>',
        function()
            local new_name = vim.trim(vim.fn.getline '.')

            api.nvim_win_close(win, true)

            if M.empty(new_name) or new_name == old_name then return end

            vim.lsp.buf.rename(new_name)
        end,
    }
end

M.open_url = function()
    local url = vim.fn.expand('<cfile>', nil)

    -- user/repo github urls
    if not url:match 'https' and url:match '/' then
        url = 'https://github.com/' .. url
    end

    vim.fn.jobstart { vim.env.BROWSER, '--new-window', url }
end

M.format = function()
    vim.lsp.buf.format {
        filter = function(client)
            return not vim.tbl_contains({
                'clangd', -- clang-format
                'cssls', -- prettierd
                'html', -- prettierd
                'jdt.ls', -- google-java-format
                'jedi_language_server', -- black/autopep8
                'jsonls', -- prettierd
                'pyright', -- black/autopep8
                'sqls', -- sql-formatter
                'sumneko_lua', --stylua
                'tsserver', -- prettierd
            }, client.name)
        end,
    }
end

M.rfind = function(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then return nil end

    return #str - revpos
end

M.map = function(mapping, opts)
    local kopts = { noremap = true, silent = true }

    if opts then
        for k, v in pairs(opts) do
            kopts[k] = v
        end
    end

    vim.keymap.set(mapping[1], mapping[2], mapping[3], kopts)
end

M.bmap = function(mapping, opts)
    opts = opts or {}
    opts.buffer = 0
    M.map(mapping, opts)
end

M.mapstr = function(req, meth)
    return M.empty(meth) and ('<cmd>%s<cr>'):format(req)
        or ([[<cmd>lua require('%s').%s<cr>]]):format(req, meth)
end

return M
