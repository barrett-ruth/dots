local colors = require('colors')
colors.setup('dark', 'dark')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('Conceal', { fg = cs.med_grey, bg = cs.bg })
hi('CursorLineNr', { fg = cs.grey })
hi('Error', { fg = cs.red }, { 'ErrorMsg' })
hi('Folded', { fg = cs.med_grey, bg = cs.light_black })
hi('Identifier', { fg = cs.black })
hi('Keyword', { fg = cs.white })
hi('LineNr', { fg = cs.med_grey })
hi('MatchParen', { fg = cs.white, bg = cs.med_grey })
hi('MoreMsg', { fg = cs.yellow })
hi('Normal', { fg = cs.white, bg = cs.bg })
hi('NonText', { fg = cs.black })
hi('SignColumn', { bg = cs.bg })
hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')
hi('Special', { fg = cs.yellow })
hi('SpecialKey', { fg = cs.cyan })
hi('Statement', { fg = cs.purple })
hi('Visual', { bg = cs.dark_grey })
hi('WarningMsg', { fg = cs.yellow })

hi('Pmenu', { bg = '#343434' })
hi('PmenuSbar', { bg = '#343434' })
hi('PmenuSel', { bg = cs.med_grey }, { 'PmenuThumb' })

hi('NormalFloat', { fg = cs.white, bg = cs.black }, {
    'LspInfoBorder',
    'NullLsInfoBorder',
    'FzfLuaBorder',
    'FloatBorder',
})

hi('@attribute', { fg = cs.light_blue })
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
hi('@tag.delimiter', { fg = cs.black }, { '@tag.attribute' })
tshi('Title', { fg = cs.light_blue })
tshi('Type', { fg = cs.purple }, { '@type.builtin' })

hi('@text.emphasis', { italic = true })
hi('@text.strong', { bold = true })
hi('@text.underline', { underline = true })
hi('@text.uri', { fg = cs.cyan, underline = true })

hi('@text.danger', { fg = cs.light_red, bold = true })
hi('@text.todo', { fg = cs.light_yellow, bold = true })
hi('@text.warning', { fg = cs.light_purple, bold = true })

hi('@lsp.type.comment', { none = true })
hi('@lsp.type.class', { none = true })
hi('@lsp.type.macro', { none = true })

hi('LspInlayHint', { fg = cs.med_grey })
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

hi('SpellBad', { underline = true, special = cs.red }, { '@spell.bad' })
hi('SpellRare', { underline = true, special = cs.purple }, { '@spell.rare' })
hi('SpellCap', { underline = true, special = cs.blue }, { '@spell.cap' })
hi('SpellLocal', { underline = true, special = cs.cyan }, { '@spell.local' })

hi('CmpItemAbbrMatch', { fg = cs.green })
hi('CmpItemAbbrMatchFuzzy', { fg = cs.green })

hi('Directory', { fg = cs.light_orange }, { 'OilDir' })

-- gitsigns
hi('GitSignsAdd', { fg = cs.light_green })
hi('GitSignsChange', { fg = cs.light_blue })
hi('GitSignsDelete', { fg = cs.light_red })
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.grey })

-- git
hi('gitCommitSummary', { fg = cs.white })

hi('DiffAdd', { fg = cs.bg, bg = cs.light_green }, { '@text.diff.add' })
hi('DiffDelete', { fg = cs.bg, bg = cs.light_red }, { '@text.diff.delete' })
hi('DiffChange', { fg = cs.bg, bg = cs.light_blue })
