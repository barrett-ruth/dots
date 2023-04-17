vim.cmd [[
    syntax match RunDone /\V[DONE]\v( exited with code\=0)@=/
    syntax match RunFailed /\V[ERROR]\v( exited with code=[^0])@=/
    syntax match RunKilled /\V[SIGKILL]\v( exited with code=[^0])@=/
]]

local colors = require 'colors'
local cs = colors[vim.g.colors_name]

colors.hi('RunDone', { fg = cs.green })
colors.hi('RunFailed', { fg = cs.red })
colors.hi('RunKilled', { fg = cs.purple })
