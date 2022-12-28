local M = {}

function M.empty(s)
    return s == '' or s == nil
end

function M.rfind(str, char)
    local revpos = str:reverse():find(char)

    if revpos == nil then
        return nil
    end

    return #str - revpos + 1
end

return M
