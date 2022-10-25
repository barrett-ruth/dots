local g = vim.g

local utils = require 'utils'

utils.map({ 'n', '<leader>db', ':DB ' }, { silent = false })
utils.map { 'n', '<leader>du', utils.mapstr 'DBUIToggle' }

g.db_ui_save_location = vim.env.XDG_DATA_HOME .. '/nvim/db_ui'
g.db_ui_show_help = 0
g.db_ui_icons = {
    expanded = 'v',
    collapsed = '>',
    saved_query = '*',
    new_query = '+',
    tables = '~',
    buffers = '>>',
    connection_ok = '✓',
    connection_error = '✕',
}
