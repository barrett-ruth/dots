vim.cmd [[
    syn match RunDone /\V[DONE]\v( exited with code\=0)@=/
    syn match RunFail /\V[ERROR]\v( exited with code=[^0])@=/
]]

local gruvbox = require 'gruvbox'
local cs, hi = gruvbox.cs, gruvbox.hi

hi('RunDone', { fg = cs.green })
hi('RunFail', { fg = cs.red })
