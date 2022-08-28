require('hop').setup()

local utils = require 'utils'
utils.map { 'n', '<c-h>', utils.mapstr 'HopWord' }
utils.map { 'n', 'H', utils.mapstr 'HopChar2' }
