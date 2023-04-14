local function newline(lr)
    return s(
        { trig = lr[2], wordTrig = false },
        { t { lr[1], '\t' }, i(1), t { '', lr[2]:reverse() } }
    )
end

return {
    newline { '[', ',]' },
    newline { '{', ',}' },
    newline { '(', ',)' },
}
