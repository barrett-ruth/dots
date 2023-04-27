local function newline(lr, trig)
    return s(
        { trig = trig, wordTrig = false },
        { t { lr[1], '\t' }, i(1), t { '', lr[2] } }
    )
end

local function sameline(lr, trig)
    return s({ trig = trig, wordTrig = false }, { t(lr[1]), i(1), t(lr[2]) })
end

-- TODO: insert quotes when inside functionc all (TS)
return {
    newline({ '{', '}' }, '{'),
    newline({ '[', ']' }, '['),
    newline({ '(', ')' }, '('),
    newline({ '{', '},' }, '{,'),
    newline({ '[', '],' }, '[,'),
    newline({ '(', '),' }, '(,'),

    sameline({ '{ ', ' }' }, '{ '),
    sameline({ '[ ', ' ]' }, '[ '),
    sameline({ '( ', ' )' }, '( '),
}
