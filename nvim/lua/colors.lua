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
    hi = function(group, highlights)
        if highlights.none then
            highlights.none = nil
            highlights.undercurl = false
            highlights.italic = false
            highlights.bold = false
        end
        vim.api.nvim_set_hl(0, group, highlights)
    end,
    link = function(from, to)
        vim.api.nvim_set_hl(0, to, { link = from })
    end,
}
