local fold =
    '%#FoldColumn#%{foldlevel(v:lnum)>foldlevel(v:lnum-1)?(foldclosed(v:lnum)==-1?"v ":"> "):" "}'

_G.click = function()
    local lnum = vim.fn.getmousepos().line

    -- Only lines with a mark should be clickable
    if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
        return
    end

    vim.cmd(
        lnum .. 'fold' .. (vim.fn.foldclosed(lnum) == -1 and 'close' or 'open')
    )
end

return {
    num = function()
        if vim.v.relnum == 0 then
            return '%#CursorLineNr#' .. vim.v.lnum
        end

        return '%#LineNr#' .. vim.v.relnum
    end,
    statuscolumn = function()
        return '%@v:lua.click@'
            .. fold
            .. '%s%='
            .. '%{%v:lua.require("lines.statuscolumn").num()%} '
    end,
}
