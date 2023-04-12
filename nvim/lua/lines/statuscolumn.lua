return {
    num = function()
        if vim.v.virtnum < 0 then
            return ''
        elseif vim.v.relnum == 0 then
            return '%#CursorLineNr#' .. vim.v.lnum
        end

        return '%#LineNr#' .. vim.v.relnum
    end,
    statuscolumn = function()
        return '%s%=%{%v:lua.require("lines.statuscolumn").num()%} '
    end,
}
