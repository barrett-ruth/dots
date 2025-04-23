local colors = require('colors')
colors.setup('bore', 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('CursorLine', { bg = cs.white }, { 'ColorColumn', 'Folded' })
hi('Directory', { fg = cs.black })
hi('Error', { fg = cs.black })
hi('ErrorMsg', { bold = true, underline = true, fg = cs.black })
hi('MoreMsg', { bold = true, fg = cs.black }, { 'WarningMsg' })
hi('NormalFloat', { bg = cs.bg }, {
    'LspInfoBorder',
    'FloatBorder',
    'FloatShadow',
    'FloatShadowThrough',
})
hi('LineNr', { fg = cs.black }, { 'SignColumn' })
hi('CursorLineNr', { fg = cs.black })
hi(
    'Normal',
    { fg = cs.black, bg = cs.white },
    { 'Identifier', 'StatusLine', 'StatusLineNC' }
)
hi('Special', { fg = cs.black, bg = 'none' })
hi('NonText', { fg = cs.black }, { 'Whitespace' })
hi('Question', { fg = cs.black })
hi('Search', { reverse = true }, { 'IncSearch', 'Visual', 'MatchParen' })
hi('Pmenu', { bg = cs.white })
hi('PmenuSel', { reverse = true })
hi('ModeMsg', { fg = cs.black })

tshi('Boolean', { fg = cs.black }, { '@constant.builtin' })
tshi('Comment', { fg = cs.black })
tshi('Constant', { fg = cs.black })
tshi('Define', { fg = cs.black })
tshi('Function', { fg = cs.black }, { '@function.builtin', '@function.macro' })
tshi('Include', { fg = cs.black })
tshi('Keyword', { fg = cs.black }, { 'Statement' })
tshi('Namespace', { fg = cs.black })
tshi('Number', { fg = cs.black })
tshi(
    'Operator',
    { fg = cs.black },
    { '@keyword.operator', '@conditional.ternary' }
)
hi('Delimiter', { none = true })
hi('@punctuation.delimiter', { fg = cs.light_black })
tshi('PreProc', { fg = cs.black })
tshi('String', { fg = cs.black }, { '@character' })
hi('@string.escape', { fg = cs.black })
tshi('Title', { bold = true, fg = cs.black })
tshi('Variable', { none = true }, { '@constant.python' })

tshi('Type', { fg = cs.black })
hi('@lsp.type.comment', { none = true }, { '@lsp.type.macro' })

hi('@text.emphasis', { italic = true })
hi('@text.strong', { bold = true })
hi('@text.underline', { underline = true })
hi('@text.uri', { fg = cs.black, underline = true }, { '@text.reference' })
hi('@text.danger', { fg = cs.black, bold = true, italic = true })
hi('@text.note', { fg = cs.black, bold = true, italic = true })
hi('@text.todo', { fg = cs.black, bold = true, italic = true }, { 'Todo' })
hi('@text.warning', { fg = cs.black, bold = true, italic = true })

hi('LspInlayHint', { fg = cs.black })
hi(
    'DiagnosticError',
    { fg = cs.black },
    { 'DiagnosticFloatingError', 'DiagnosticSignError' }
)
hi(
    'DiagnosticWarn',
    { fg = cs.black },
    { 'DiagnosticFloatingWarn', 'DiagnosticSignWarn' }
)
hi(
    'DiagnosticHint',
    { fg = cs.black },
    { 'DiagnosticFloatingHint', 'DiagnosticSignHint' }
)
hi(
    'DiagnosticOk',
    { fg = cs.black },
    { 'DiagnosticFloatingOk', 'DiagnosticSignOk' }
)
hi(
    'DiagnosticInfo',
    { fg = cs.black },
    { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' }
)
hi('DiagnosticUnderlineError', { undercurl = true, special = cs.black })
hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.black })
hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.black })
hi('DiagnosticUnderlineOk', { undercurl = true, special = cs.black })
hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.black })

hi('@attribute.diff', { fg = cs.black })
hi('DiffAdd', { fg = cs.black }, { 'Added', '@text.diff.add', 'diffAdded' })
hi('DiffDelete', { fg = cs.black }, { 'Removed', '@text.diff.delete', 'diffRemoved' })
hi('DiffChange', { fg = cs.black })

-- gitsigns.nvim
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.black })
link('DiffAdd', 'GitSignsAdd')
link('DiffChange', 'GitSignsChange')
link('DiffDelete', 'GitSignsDelete')
-- highlight-undo.nvim

link('Search', 'HighlightUndo')

-- null-ls
link('NormalFloat', 'NullLsInfoBorder')

-- oil.nvim
link('Directory', 'OilDir')

-- language-specific
hi('cssBraces', { fg = cs.black })
