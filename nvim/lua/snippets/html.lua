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
}
