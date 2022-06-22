setl statusline=
setl nospell

lua << EOF
    local utils = require 'utils'

    utils.bmap { 'n', 'q', utils.mapstr 'q' }
EOF
