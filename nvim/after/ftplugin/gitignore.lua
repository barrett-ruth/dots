local colors = require('colors')
local cs = colors[vim.g.colors_name]

if not cs then
    return
end

if vim.g.colors_name == 'lite' then
    colors.hi('@operator.gitignore', { fg = cs.red })
    colors.hi('@punctuation.delimiter.gitignore', { fg = cs.orange })
end
