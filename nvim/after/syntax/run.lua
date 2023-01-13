vim.cmd [[
    syn match RunDone /\V[DONE]\v( exited with code\=0)@=/
    syn match RunFail /\V[ERROR]\v( exited with code=[^0])@=/
    syn match RunKilled /\V[SIGKILL]\v( exited with code=[^0])@=/
]]

local colors = require 'colors'
local hi, cs = colors.hi, colors[vim.g.colors_name]

hi('RunDone', { fg = cs.green })
hi('RunFail', { fg = cs.red })
hi('RunKilled', { fg = cs.purple })
