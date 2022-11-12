local api, lsp = vim.api, vim.lsp

local check_trigger_char = function(line_to_cursor, triggers)
    local current_char = line_to_cursor:sub(#line_to_cursor, #line_to_cursor)
    local prev_char =
        line_to_cursor:sub(#line_to_cursor - 1, #line_to_cursor - 1)

    for _, trigger_char in ipairs(triggers) do
        if
            current_char == trigger_char
            or current_char == ' ' and prev_char == trigger_char
        then
            return true
        end
    end
end

return {
    setup = function(client)
        api.nvim_create_autocmd('TextChangedI', {
            group = api.nvim_create_augroup('lsp_signature', { clear = true }),
            pattern = '<buffer>',
            callback = function()
                local triggers =
                    client.server_capabilities.signatureHelpProvider.triggerCharacters
                local pos = vim.api.nvim_win_get_cursor(0)
                local line = vim.api.nvim_get_current_line()
                local line_to_cursor = line:sub(1, pos[2])

                if check_trigger_char(line_to_cursor, triggers) then
                    lsp.buf.signature_help()
                end
            end,
        })
    end,
}
