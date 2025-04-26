local function link(from, tos)
    tos = type(tos) == 'string' and { tos } or tos
    for _, to in ipairs(tos) do
        vim.api.nvim_set_hl(0, to, { link = from })
    end
end

local function hi(group, highlights, links)
    if highlights.none then
        highlights.none = nil
        highlights.undercurl = false
        highlights.italic = false
        highlights.bold = false
        highlights.fg = 'NONE'
        highlights.bg = 'NONE'
    end
    vim.api.nvim_set_hl(0, group, highlights)
    for _, other in ipairs(links or {}) do
        link(group, other)
    end
end

return {
    bore = {
        black = '#000000',
        grey = '#666666',
        red = '#B22222',
        green = '#228B22',
        yellow = '#B8860B',
        blue = '#27408B',
        magenta = '#8B008B',
        cyan = '#00BFFF',
        white = '#ffffff',

        light_black = '#555555',
        light_grey = '#ECECEC',
        light_red = '#ff0000',
        light_green = '#00ff00',
        light_yellow = '#ffa500',
        light_blue = '#0000ff',
        light_magenta = '#ff00ff',
        light_cyan = '#00ffff',
        light_white = '#ffffff',
    },
    setup = function(colors_name, background)
        if vim.g.colors_name then
            vim.cmd.hi('clear')
        end

        if vim.fn.exists('syntax_one') then
            vim.cmd.syntax('reset')
        end

        vim.g.colors_name = colors_name
        vim.o.background = background
    end,
    hi = hi,
    tshi = function(group, highlights, links)
        hi(group, highlights)

        local tsgroup = '@' .. group:gsub('^%L', string.lower)
        link(group, tsgroup)

        for _, to in ipairs(links or {}) do
            link(group, to)
        end
    end,
    link = link,
}
