local g = vim.g

if g.colors_name then
    vim.cmd.hi 'clear'
end

g.colors_name = 'lite'

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
for _, color in ipairs {
    'Red',
    'Orange',
    'Yellow',
    'Green',
    'Cyan',
    'Blue',
    'Purple',
    'Grey',
    'White',
    'Black',
} do
    hi(color, { fg = cs[color:lower()] })
end

hi('Normal', { fg = cs.black, bg = cs.white })

hi('LineNr', { fg = '#AEB3C2' })
hi('CursorLineNr', { fg = '#767A8A' })
hi('CursorLine', { bg = cs.hi })

hi('SignColumn', { bg = cs.white })

hi('Statusline', { none = true })
hi('NormalFloat', { none = true })
hi('Search', { none = true })
hi('Search', { reverse = true })
hi('Statement', { italic = true, fg = cs.blue })
hi('Title', { fg = cs.blue })

hi('String', { fg = cs.green })
link('String', '@string')
hi('@string.escape', { fg = cs.blue })

hi('Number', { fg = cs.light_blue })
link('Number', '@number')

hi('Keyword', { fg = cs.blue })
link('Keyword', '@keyword')
link('@keyword', '@keyword.operator')
link('@keyword', '@exception')

hi('Comment', { italic = true, fg = cs.grey })
link('Comment', '@comment')

hi('Function', { fg = cs.cyan })
link('Function', '@function')
hi('@function.builtin', { fg = cs.blue })

hi('Identifier', { fg = cs.black })
link('Identifier', '@identifier')

hi('Label', { fg = cs.purple })
link('Label', '@label')

hi('Constant', { italic = true, fg = cs.purple })
link('Constant', '@constant')
hi('@constant.builtin', { italic = true, fg = cs.black })

hi('@variable.builtin', { fg = cs.light_purple })

hi('Include', { fg = cs.blue })
link('Include', '@include')

hi('Type', { fg = cs.blue })
link('Type', '@type')

hi('Tag', { fg = cs.blue })
link('Tag', '@tag')
hi('@tag.attribute', { fg = cs.light_blue })

hi('@conditional', { fg = cs.blue })
link('@conditional', '@repeat')

hi('Operator', { fg = cs.blue })
link('Operator', '@operator')

hi('@punctuation', { fg = cs.black })

hi('@attribute', { fg = cs.yellow })

-- pmenu
hi('Pmenu', { bg = cs.white })
hi('PmenuSel', { bg = cs.grey })

-- nvim-cmp
hi('CmpItemAbbrMatch', { fg = cs.green })
hi('CmpItemAbbrMatchFuzzy', { fg = cs.green })

-- nvim-tree
hi('NvimTreeIndentMarker', { fg = cs.grey })
hi('Directory', { fg = cs.light_blue })
link('Directory', 'NvimTreeFolderName')
hi('NvimTreeRootFolder', { fg = cs.cyan })
hi('NvimTreeSpecialFile', { bold = true, fg = cs.yellow, underline = true })
hi('NvimTreeExecFile', { bold = true, fg = cs.green })

-- lsp/diagnostics
hi('LspSignatureActiveParameter', { italic = true, underline = true })
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
hi('diffIndexLine', { fg = cs.purple })

-- gitsigns
hi('GitSignsAdd', { fg = cs.green })
hi('GitSignsChange', { fg = cs.blue })
hi('GitSignsDelete', { fg = cs.red })

-- spelling
hi('SpellBad', { underline = true, special = cs.red })
link('SpellBad', '@spell.bad')
hi('SpellRare', { underline = true, special = cs.purple })
link('SpellRare', '@spell.rare')
hi('SpellCap', { underline = true, special = cs.blue })
link('SpellCap', '@spell.cap')
hi('SpellLocal', { underline = true, special = cs.cyan })
link('SpellLocal', '@spell.local')
