local navic_icons = {
    Class = '',
    Constant = '',
    Constructor = '',
    Keyword = '',
    Enum = '',
    Field = '',
    File = '',
    Function = '',
    Interface = '',
    Method = '',
    Module = '',
    Namespace = '',
    Number = '',
    Object = '',
    Operator = '',
    Array = '',
    Boolean = '',
    EnumMember = '',
    Key = '',
    Package = '',
    Event = '',
    Property = '',
    String = '',
    Variable = '',
    Folder = '',
    Reference = '',
    Struct = '',
    Null = '',
    Text = '',
    TypeParameter = '',
    Unit = '',
}

vim.g.navic_silence = true

require('nvim-navic').setup { icons = navic_icons, depth_limit = 3 }
