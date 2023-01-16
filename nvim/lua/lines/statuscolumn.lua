local fold =
    '%#FoldColumn#%{foldlevel(v:lnum)>foldlevel(v:lnum-1)?(foldclosed(v:lnum)==-1?"v ":"> "):" "}'

return {
    num = function()
        if vim.v.relnum == 0 then
            return '%#CursorLineNr#' .. vim.v.lnum
        end

        return '%#LineNr#' .. vim.v.relnum
    end,
    statuscolumn = function()
        return
            fold .. '%s%=' .. '%{%v:lua.require("lines.statuscolumn").num()%} '
    end,
}
