local word = function(index)
    return f(function(name)
        return name[1][1]:match('([^ ]*)')
    end, { index })
end

return {
    s('<', fmt('<{}>\n\t{}\n</{}>', { i(1), i(2), word(1) })),
}
