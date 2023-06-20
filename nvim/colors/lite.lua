local colors = require('colors')
colors.setup('lite', 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('CursorLineNr', { fg = cs.black })
hi('Error', { fg = cs.red })
hi('Identifier', { fg = cs.black })
hi('LineNr', { fg = cs.grey })
hi('MatchParen', { reverse = true })
hi('NonText', { fg = cs.black })
hi('Normal', { fg = cs.black, bg = cs.white })

hi('NormalFloat', { fg = cs.black, bg = cs.white })
link('NormalFloat', 'LspInfoBorder')
link('NormalFloat', 'NullLsInfoBorder')
link('NormalFloat', 'FzfLuaBorder')
link('NormalFloat', 'FloatBorder')

hi('Pmenu', { fg = cs.black, bg = cs.light_grey })
hi('PmenuSel', { bg = cs.med_grey })
hi('PmenuSBar', { bg = cs.light_grey })
hi('PmenuThumb', { bg = cs.med_grey })
hi('CmpItemAbbrMatchDefault', { fg = cs.green, bold = true })
hi('CmpItemAbbrMatchFuzzyDefault', { fg = cs.green, bold = true })

hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')
hi('Special', { fg = cs.yellow })
hi('SpecialKey', { fg = cs.cyan })
hi('Statement', { fg = cs.black })
hi('Visual', { bg = '#BFDBFE' })

tshi('Boolean', { fg = cs.purple })

tshi('Comment', { fg = cs.grey }, { '@string.documentation' })

tshi('Conceal', { fg = cs.black })

tshi('Constant', { fg = cs.purple }, { '@constant.builtin' })
tshi('Conditional', { fg = cs.black }, { '@conditional.ternary' })

tshi(
    'Function',
    { fg = cs.green },
    { '@function.builtin', '@function.call', '@method.call' }
)
hi('@function.macro', { fg = cs.black })

tshi('Include', { fg = cs.red })

tshi('Keyword', { fg = cs.black })

tshi('Label', { fg = cs.green })

tshi('Number', { fg = cs.purple })

tshi('Operator', { fg = cs.black })

tshi('PreProc', { fg = cs.red })

hi('@punctuation', { fg = cs.black })

tshi('String', { fg = cs.yellow }, { '@string.escape' })

tshi('Structure', { fg = cs.blue })

tshi('Repeat', { fg = cs.black })

tshi('Tag', { fg = cs.blue })
hi('@tag.delimiter', { fg = cs.black })

hi('@text.emphasis', { italic = true })
hi('@text.strong', { bold = true })
hi('@text.uri', { underline = true })

hi('@lsp.type.comment', { none = true })

tshi('Title', { fg = cs.purple })

tshi('Type', { fg = cs.blue }, { '@type.builtin' })

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
