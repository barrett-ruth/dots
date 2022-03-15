aug qf
    au! FileType qf lua local utils = require 'utils'; utils.bmap { 'n', '<c-v>', '<cr>' .. utils.mapstr 'bp' .. utils.mapstr 'vert sbn' }
aug end
