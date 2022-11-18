local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local newline = function(lr)
    return s(snipopts(lr[2]), { t { lr[1], '\t' }, i(1), t { '', lr[2] } })
end

return {
    newline { '[[', ']],' },
    newline { '{', '},' },
    newline { '[', '],' },
    newline { '[', '],' },
    newline { '{', '}' },
    newline { '[', ']' },
    newline { '[', ']' },
}
