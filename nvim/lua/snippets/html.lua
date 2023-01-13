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
    s(
        'bp',
        fmt(
            [[
                <!DOCTYPE html>
                <html lang="en">
                  <head>
                    <meta charset="UTF-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1" />
                    <title>{}</title>
                  </head>

                  <body>
                    {}
                  </body>
                </html>
            ]],
            { i(1), i(2) }
        )
    ),
}
