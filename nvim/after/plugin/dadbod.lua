map({ 'n', '<leader>db', ':DB ' }, { silent = false })
map { 'n', '<leader>du', '<cmd>DBUIToggle<cr>' }

local g = vim.g

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
