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
        local text = ' '
        if
            vim.wo.foldenable
            and vim.fn.foldlevel(vim.v.lnum)
                > vim.fn.foldlevel(vim.v.lnum - 1)
        then
            if vim.fn.foldclosed(vim.v.lnum) == -1 then
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
