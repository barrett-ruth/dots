local function snipopts(trig)
    return { trig = trig, wordTrig = false }
end

local function inline(lr)
    return s(snipopts(lr[2]), { t(lr[1]), i(1), t(lr[2]) })
end

local function newline(lr)
    return s(snipopts(lr[2]), { t { lr[1], '\t' }, i(1), t { '', lr[2] } })
end

return {
    newline { '[', '],' },
    newline { '{', '},' },
    newline { '(', '),' },

    inline { '[ ', ' ]' },
    inline { '{ ', ' }' },
    inline { '( ', ' )' },
}
