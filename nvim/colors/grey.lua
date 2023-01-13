local g = vim.g

if g.colors_name then
    vim.cmd.hi 'clear'
end

g.colors_name = 'grey'

if vim.fn.exists 'syntax_on' then
    vim.cmd.syntax 'reset'
end

local colors = require 'colors'
local hi, link, cs = colors.hi, colors.link, colors[g.colors_name]
