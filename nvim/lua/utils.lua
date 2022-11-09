local M = {}

M.empty = function(s) return s == '' or s == nil end

M.rfind = function(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then return nil end

    return #str - revpos + 1
end

return M
