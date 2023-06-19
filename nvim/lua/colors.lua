local function hi(group, highlights)
    if highlights.none then
        highlights.none = nil
        highlights.undercurl = false
        highlights.italic = false
        highlights.bold = false
    end
    vim.api.nvim_set_hl(0, group, highlights)
end

local function link(from, to)
    vim.api.nvim_set_hl(0, to, { link = from })
end

return {
    gruvbox = {
        bg = '#282828',
        black = '#5a524c',
        red = '#ea6962',
        light_red = '#ef938e',
        green = '#a9b665',
        light_green = '#bbc585',
        yellow = '#d8a657',
        light_yellow = '#e1bb7e',
        blue = '#7daea3',
        light_blue = '#9dc2ba',
        purple = '#d3869b',
        light_purple = '#e1acbb',
        cyan = '#89b482',
        light_cyan = '#a7c7a2',
        white = '#d4be98',
        light_white = '#e2d3ba',
        orange = '#e78a4e',
        grey = '#928374',
        med_grey = '#45403d',
        dark_grey = '#32302f',
        hi = '#a89984',
    },
    vscode = {
        white = '#F7F7F7',
        light_blue = '#007ACC',
        med_blue = '#285EBA',
        blue = '#0000FF',
        light_green = '#098658',
        green = '#008000',
        red = '#A31515',
        dark_red = '#800000',
        light_grey = '#E7E7E7',
        grey = '#929292',
        black = '#000000',
    },
    dark = {
        light_red = '#F07178',
        red = '#DC6068',

        light_orange = '#F78C6C',
        orange = '#E2795B',

        light_yellow = '#FFCB6C',
        yellow = '#E6B455',

        light_green = '#C3E88D',
        green = '#ABCF76',

        light_blue = '#82AAFF',
        blue = '#6E98EB',

        light_cyan = '#89DDFF',
        cyan = '#71C6E7',

        light_purple = '#C792EA',
        purple = '#B480D6',

        grey = '#8C8B8B',
        med_grey = '#515151',
        dark_grey = '#404040',
        light_black = '#2D2D2D',

        white = '#EEFFFF',
        dark_white = '#B0BEC5',

        bg = '#212121',
    },
    lite = {
        white = '#f8f7f7',
        red = '#aa3731',
        light_red = '#F05050',
        orange = '#E16F24',
        yellow = '#cb9000',
        light_yellow = '#ffbc5d',
        green = '#448c27',
        light_green = '#60cb00',
        cyan = '#0083b2',
        light_cyan = '#00aacb',
        blue = '#325cc0',
        light_blue = '#007acc',
        purple = '#7a3e9d',
        light_purple = '#e64ce6',
        light_grey = '#e7e7e7',
        med_grey = '#c7c7c7',
        grey = '#777777',
        black = '#000000',
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
