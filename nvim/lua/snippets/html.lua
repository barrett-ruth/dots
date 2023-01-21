local function subtag()
    return sn(
        nil,
        c(1, {
            t '',
            sn(nil, { t { '', '\t<li>' }, i(1), t '</li>', d(2, subtag, {}) }),
        })
    )
end

local function list(tag)
    return s(tag, {
        t { ('<%s>'):format(tag), '\t<li>' },
        i(1),
        t '</li>',
        d(2, subtag, {}),
        t { '', ('</%s>'):format(tag) },
    })
end

return {
    s({ trig = '%.(.*)', regTrig = true }, {
        t '<div class="',
        f(function(_, snip)
            return snip.captures[1]
        end, {}),
        t '">',
        i(1),
        t '</div>',
    }),
    list 'ul',
    list 'ol',
}
