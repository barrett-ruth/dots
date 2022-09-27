local utils = require 'utils'

utils.map({ 'n', '<leader>db', ':DB ' }, { silent = false })
utils.map { 'n', '<leader>du', utils.mapstr 'DBUIToggle' }

vim.g.db_ui_save_location = vim.env.XDG_DATA_HOME .. '/nvim/db_ui'
vim.g.db_ui_show_help = 0
vim.g.db_ui_icons = {
    expanded = 'v',
    collapsed = '>',
    saved_query = '*',
    new_query = '+',
    tables = '~',
    buffers = '>>',
    connection_ok = '✓',
    connection_error = '✕',
}
