return {
    num = function()
        if math.abs(vim.v.virtnum) > 0 then
            return ''
        elseif vim.v.relnum == 0 then
            return '%#CursorLineNr#' .. vim.v.lnum
        end

        return '%#LineNr#' .. vim.v.relnum
    end,
    fold = function()
        if not vim.wo.foldenable or math.abs(vim.v.virtnum) > 0 then
            return ''
        end

        local edges = require('fold').edges
        edges = edges[vim.api.nvim_get_current_buf()] or {}

        local text = ' '
        local lnum = vim.v.lnum
        if edges[lnum] then
            if vim.fn.foldclosed(lnum) == -1 then
                text = 'v'
            else
                text = '>'
            end
        end

        return '%#FoldColumn#' .. text
    end,
    statuscolumn = function()
        return '%{%v:lua.require("lines.statuscolumn").fold()%}%s%=%{%v:lua.require("lines.statuscolumn").num()%} '
    end,
}
