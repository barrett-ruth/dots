local function link(from, to)
    vim.api.nvim_set_hl(0, to, { link = from })
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
    light = {
        black = '#000000',
        red = '#ff0000',
        green = '#00ff00',
        yellow = '#ffa500',
        blue = '#0000ff',
        magenta = '#ff00ff',
        cyan = '#00ffff',
        white = '#ffffff',

        light_black = '#555555',
        light_red = '#ff5555',
        light_green = '#55ff55',
        light_yellow = '#ffae42',
        light_blue = '#5555ff',
        light_magenta = '#ff55ff',
        light_cyan = '#55ffff',
        light_white = '#ffffff',
    },
    gruvbox = {
        black = '#282828',
        red = '#EA6962',
        green = '#A9B665',
        yellow = '#D8A657',
        blue = '#7DAEA3',
        magenta = '#D3869B',
        cyan = '#89B482',
        white = '#D4BE98',

        light_black = '#928374',
        light_red = '#EF938E',
        light_green = '#BBC585',
        light_yellow = '#E1BB7E',
        light_blue = '#9DC2BA',
        light_magenta = '#E1ACBB',
        light_cyan = '#A7C7A2',
        light_white = '#E2D3BA',

        orange = '#E78A4E',

        light_grey = '#A89984',
        grey = '#5A524C',
        med_grey = '#45403D',
        dark_grey = '#32302F',
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
