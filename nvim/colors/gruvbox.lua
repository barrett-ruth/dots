local g = vim.g

if g.colors_name then
    vim.cmd.hi 'clear'
end

g.colors_name = 'gruvbox'

if vim.fn.exists 'syntax_on' then
    vim.cmd.syntax 'reset'
end

local colors = require 'colors'
local hi, link, cs = colors.hi, colors.link, colors[g.colors_name]

g.terminal_ansi_colors = {
    cs.black,
    cs.red,
    cs.green,
    cs.yellow,
    cs.blue,
    cs.purple,
    cs.cyan,
    cs.white,
    cs.black,
    cs.red,
    cs.green,
    cs.yellow,
    cs.blue,
    cs.purple,
    cs.cyan,
    cs.white,
}

-- basic colors
hi('Red', { fg = cs.red })
hi('Orange', { fg = cs.orange })
hi('Yellow', { fg = cs.yellow })
hi('Green', { fg = cs.green })
hi('Cyan', { fg = cs.cyan })
hi('Blue', { fg = cs.blue })
hi('Purple', { fg = cs.purple })
hi('Grey', { fg = cs.grey })
hi('White', { fg = cs.white })
hi('Black', { fg = cs.black })

-- basic ui
hi('Normal', { fg = cs.white, bg = cs.bg })

-- messages
hi('ErrorMsg', { bold = true, underline = true, fg = cs.red, bg = 'NONE' })
hi('MoreMsg', { bold = true, fg = cs.yellow })
hi('WarningMsg', { bold = true, fg = cs.yellow })

-- line numbers
hi('LineNr', { fg = cs.black })
hi('CursorLine', { bg = cs.dark_grey })
hi('CursorLineNr', { fg = cs.grey })

-- folds/columns
hi('ColorColumn', { bg = cs.dark_grey })
hi('SignColumn', { bg = cs.bg })

-- health
hi('HealthSuccess', { fg = cs.green })
hi('HealthWarning', { fg = cs.yellow })
hi('HealthError', { fg = cs.red })

-- help
hi('helpNote', { bold = true, fg = cs.purple })
hi('helpExample', { none = true, fg = cs.green })

hi('SpecialKey', { fg = cs.black })
hi('VertSplit', { fg = cs.black })
hi('MatchParen', { bg = cs.med_grey })

hi('NormalFloat', { bg = 'NONE' })
hi('Visual', { bg = cs.med_grey })
hi('Whitespace', { fg = cs.black })

hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')
hi('Conceal', { fg = cs.hi, bg = 'NONE' })
hi('Error', { fg = cs.red })
hi('Question', { none = true, fg = cs.yellow })
hi('Special', { fg = cs.yellow })
hi('Statement', { italic = true, fg = cs.red })
hi('Identifier', { fg = cs.blue })

-- pmenu
hi('Pmenu', { bg = cs.med_grey })
hi('PmenuSel', { fg = cs.med_grey, bg = cs.hi })
hi('PmenuSbar', { bg = cs.med_grey })
hi('PmenuThumb', { bg = cs.hi })

-- winbar
hi('WinBar', { fg = cs.grey, none = true })

-- nvim-cmp
hi('CmpItemAbbrMatch', { fg = cs.green })
hi('CmpItemAbbrMatchFuzzy', { fg = cs.green })

-- dirbuf.nvim
hi('Directory', { fg = cs.light_blue })

-- telescope
link('Green', 'TelescopeMatching')

-- mini
link('Visual', 'MiniCursorword')
hi('MiniCursorwordCurrent', { bg = cs.bg })

-- lsp/diagnostics
hi('LspSignatureActiveParameter', { underline = true, italic = true })
hi('DiagnosticError', { fg = cs.red })
hi('DiagnosticWarn', { fg = cs.yellow })
hi('DiagnosticHint', { fg = cs.green })
hi('DiagnosticInfo', { fg = cs.blue })
hi('DiagnosticUnderlineError', { undercurl = true, special = cs.red })
hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.yellow })
hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.green })
hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.blue })

for _, v in ipairs { 'Error', 'Warn', 'Hint', 'Info' } do
    link('Diagnostic' .. v, 'DiagnosticFloating' .. v)
    link('Diagnostic' .. v, 'DiagnosticSign' .. v)
end

-- diffs
hi('DiffAdd', { fg = cs.green, reverse = true })
hi('DiffChange', { fg = cs.blue, reverse = true })
hi('DiffDelete', { fg = cs.red, reverse = true })
hi('diffAdded', { fg = cs.green })
hi('diffRemoved', { fg = cs.red })
hi('diffFile', { fg = cs.cyan })
hi('diffLine', { fg = cs.grey })
hi('diffOldFile', { fg = cs.yellow })
hi('diffNewFile', { fg = cs.orange })
hi('diffIndexLine', { fg = cs.purple })

-- gitsigns
hi('GitSignsAdd', { fg = cs.green })
hi('GitSignsChange', { fg = cs.blue })
hi('GitSignsDelete', { fg = cs.red })

-- spelling
hi('SpellBad', { underline = true, special = cs.red })
hi('SpellRare', { underline = true, special = cs.purple })
hi('SpellCap', { underline = true, special = cs.blue })
hi('SpellLocal', { underline = true, special = cs.cyan })
link('SpellBad', '@spell.bad')
link('SpellRare', '@spell.rare')
link('SpellCap', '@spell.cap')
link('SpellLocal', '@spell.local')

-- comments
hi('Comment', { italic = true, fg = cs.grey })
link('Comment', '@comment')

-- text
hi('Title', { bold = true, fg = cs.orange })
link('Title', '@text.title')
hi('@text.emphasis', { italic = true })
hi('@text.reference', { fg = cs.blue })
hi('@text.strong', { bold = true })
hi('@text.todo', { fg = cs.purple, bold = true })
hi('@text.uri', { fg = cs.blue })
hi('@text.warning', { fg = cs.yellow, bold = true })
link('@text.warning', 'Todo')

-- booleans
hi('Boolean', { fg = cs.purple })
link('Boolean', '@boolean')

-- constants
hi('Constant', { fg = cs.white })
link('Constant', '@constant')
hi('@constant.builtin', { italic = true, fg = cs.purple })

-- strings
hi('String', { fg = cs.yellow })
link('String', '@string')
hi('@string.escape', { fg = cs.green })

-- operators
hi('Operator', { fg = cs.orange })
link('Operator', '@operator')
link('Operator', '@keyword.operator')

-- types
hi('Type', { fg = cs.yellow })
link('Type', '@type')
link('Type', '@type.builtin')
hi('@type.qualifier', { fg = cs.orange })

-- functions
hi('Function', { fg = cs.green })
link('Function', '@function')
link('Function', '@method')
hi('@function.builtin', { fg = cs.green })

-- macros
hi('@macro', { fg = cs.green })
link('@macro', '@function.macro')
hi('PreProc', { fg = cs.purple })
link('PreProc', '@preproc')

-- keywords
hi('Keyword', { fg = cs.red })
link('Keyword', '@keyword')
link('Keyword', '@keyword.function')
hi('@conditional', { fg = cs.red })
hi('@repeat', { fg = cs.red })

-- numbers
hi('Number', { fg = cs.purple })
link('Number', '@number')

-- variables
hi('@parameter', { fg = cs.white })
hi('@variable', { fg = cs.white })

-- includes
hi('Include', { fg = cs.red })
link('Include', '@include')

-- punctuation
hi('@punctuation', { fg = cs.grey })
link('@punctuation', '@punctuation.delimiter')
hi('@punctuation.bracket', { fg = cs.white })
hi('@punctuation.special', { fg = cs.green })

-- fields
hi('@property', { fg = cs.white })
hi('@field', { fg = cs.white })

-- misc
hi('@constructor', { fg = cs.cyan })
hi('@namespace', { fg = cs.cyan })

hi('StorageClass', { fg = cs.orange })
link('StorageClass', '@storageclass')
link('StorageClass', '@class')
link('StorageClass', '@struct')

hi('@enum', { fg = cs.purple })

hi('@tag', { fg = cs.orange })
hi('@tag.delimiter', { fg = cs.green })
