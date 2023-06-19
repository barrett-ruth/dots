local colors = require('colors')
colors.setup('dark', 'dark')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('CursorLineNr', { fg = cs.grey })
hi('Error', { fg = cs.red })
hi('Identifier', { fg = cs.black })
hi('Keyword', { fg = cs.white })
hi('LineNr', { fg = cs.med_grey })
hi('MatchParen', { reverse = true })
hi('Normal', { fg = cs.white, bg = cs.bg })
hi('NonText', { fg = cs.black })
hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')
hi('Special', { fg = cs.yellow })
hi('SpecialKey', { fg = cs.cyan })
hi('Visual', { bg = cs.light_black })

hi('Pmenu', { bg = '#343434' })
hi('PmenuSbar', { bg = '#343434' })
hi('PmenuSel', { bg = cs.med_grey })
hi('PmenuThumb', { bg = cs.med_grey })

hi('NormalFloat', { fg = cs.white, bg = cs.black })
link('NormalFloat', 'LspInfoBorder')
link('NormalFloat', 'NullLsInfoBorder')
link('NormalFloat', 'FzfLuaBorder')
link('NormalFloat', 'FloatBorder')

tshi('Boolean', { fg = cs.light_orange })
tshi('Comment', { fg = cs.grey })
tshi('Conditional', { fg = cs.white }, { '@conditional.ternary' })
tshi('Constant', { fg = cs.yellow }, { '@constant.builtin' })
tshi(
    'Function',
    { fg = cs.blue },
    { '@function.builtin', '@function.call', '@method.call' }
)
hi('@function.macro', { none = true })
tshi('Include', { fg = cs.white })
tshi('Label', { fg = cs.yellow })
hi('@namespace', { fg = cs.yellow })
tshi('Number', { fg = cs.light_orange })
tshi('Operator', { fg = cs.cyan }, { '@keyword.operator' })
hi('@punctuation', { fg = cs.black })
tshi('PreProc', { fg = cs.white })
tshi('Repeat', { fg = cs.white })
tshi('String', { fg = cs.green }, { '@string.escape' })
tshi('Tag', { fg = cs.blue })
hi('@tag.delimiter', { fg = cs.black })
hi('@tag.attribute', { fg = cs.black })
hi('@text.emphasis', { italic = true })
hi('@text.strong', { bold = true })
hi('@text.uri', { fg = cs.cyan, underline = true })
tshi('Title', { fg = cs.light_blue })
tshi('Type', { fg = cs.purple }, { '@type.builtin' })

hi('@lsp.type.comment', { none = true })
hi('@lsp.type.class', { none = true })
hi('@lsp.type.macro', { none = true })

hi('LspSignatureActiveParameter', { underline = true })
hi('DiagnosticError', { fg = cs.red })
hi('DiagnosticWarn', { fg = cs.yellow })
hi('DiagnosticHint', { fg = cs.green })
hi('DiagnosticInfo', { fg = cs.blue })
hi('DiagnosticUnderlineError', { undercurl = true, special = cs.red })
hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.yellow })
hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.green })
hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.blue })
for _, v in ipairs({ 'Error', 'Warn', 'Hint', 'Info' }) do
    link('Diagnostic' .. v, 'DiagnosticFloating' .. v)
    link('Diagnostic' .. v, 'DiagnosticSign' .. v)
end

hi('SpellBad', { underline = true, special = cs.red })
hi('SpellRare', { underline = true, special = cs.purple })
hi('SpellCap', { underline = true, special = cs.blue })
hi('SpellLocal', { underline = true, special = cs.cyan })
link('SpellBad', '@spell.bad')
link('SpellRare', '@spell.rare')
link('SpellCap', '@spell.cap')
link('SpellLocal', '@spell.local')

hi('CmpItemAbbrMatch', { fg = cs.green })
hi('CmpItemAbbrMatchFuzzy', { fg = cs.green })

hi('OilDir', { fg = cs.light_orange })
