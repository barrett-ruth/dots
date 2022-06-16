local icons = {}

for k, v in pairs(LSP_SYMBOLS) do
    icons[k] = v .. ' '
end

require('nvim-navic').setup {
    depth_limit = 4,
    icons = icons,
}
