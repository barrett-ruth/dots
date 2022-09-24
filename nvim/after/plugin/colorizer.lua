require('colorizer').setup {
    filetypes = vim.g.markdown_fenced_languages,
    user_default_options = {
        RRGGBB = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        css = true,
        rgb_fun = true,
        hsl_fn = true,
        tailwind = true,
        mode = 'foreground',
    },
}
