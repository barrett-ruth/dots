local word = function(i)
    return f(function(name)
        return vim.split(name[1][1], ' ')[1]
    end, { i })
end

return {
    s('</', fmt('<{} />', { i(1) })),
    s('<', fmt('<{}>{}</{}>', { i(1), i(2), word(1) })),
    s('<>', fmt('<{}>\n\t{}\n</{}>', { i(1), i(2), word(1) })),
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
                </html>
            ]],
            { i(1) }
        )
    ),
}
