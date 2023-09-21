local api, fn = vim.api, vim.fn
local group = api.nvim_create_augroup('AHLSearch', {})
local buffers = {}

local function stop_hl()
    if vim.v.hlsearch == 0 then
        return
    end

    local keycode =
        api.nvim_replace_termcodes('<cmd>nohl<cr>', true, false, true)

    api.nvim_feedkeys(keycode, 'n', false)
end

local function start_hl()
    local res = fn.getreg('/')
    if
        vim.v.hlsearch == 1
        and res
        and (res:find([[%#]]) or fn.search([[\%#\zs]] .. res, 'cnW') == 0)
    then
        stop_hl()
    end
end

local function hs_event(bufnr)
    if buffers[bufnr] then
        return
    end

    buffers[bufnr] = true

    local moved_id = api.nvim_create_autocmd('CursorMoved', {
        buffer = bufnr,
        callback = start_hl,
        group = group,
    })

    local insert_id = api.nvim_create_autocmd('InsertEnter', {
        buffer = bufnr,
        callback = stop_hl,
        group = group,
    })

    api.nvim_create_autocmd('BufDelete', {
        buffer = bufnr,
        callback = function(opt)
            buffers[bufnr] = nil
            pcall(api.nvim_del_autocmd, moved_id)
            pcall(api.nvim_del_autocmd, insert_id)
            pcall(api.nvim_del_autocmd, opt.id)
        end,
        group = group,
    })
end

return {
    setup = function()
        api.nvim_create_autocmd('BufWinEnter', {
            callback = function(opt)
                hs_event(opt.buf)
            end,
            group = group,
        })
    end,
}
