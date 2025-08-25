local colors = require('colors')
colors.setup('light', 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('red', { fg = cs.red })
hi('yellow', { fg = cs.yellow })
hi('white', { fg = cs.white })
hi('black', { fg = cs.black })
hi('magenta', { fg = cs.magenta })
hi('blue', { fg = cs.blue })
hi('cyan', { fg = cs.cyan })
hi('green', { fg = cs.green })
hi('grey', { fg = cs.grey })

hi('CursorLine', { bg = cs.light_grey }, { 'ColorColumn', 'Folded' })
hi('Directory', { fg = cs.blue })
hi('Error', { fg = cs.red })
hi('ErrorMsg', { bold = true, underline = true, fg = cs.red })
hi('MoreMsg', { bold = true, fg = cs.yellow }, { 'WarningMsg' })
hi('NormalFloat', { bg = cs.bg }, {
    'LspInfoBorder',
    'FloatBorder',
    'FloatShadow',
    'FloatShadowThrough',
})
hi('LineNr', { fg = cs.grey }, { 'SignColumn' })
hi('CursorLineNr', { fg = cs.black })
hi(
    'Normal',
    { fg = cs.black, bg = cs.white },
    { 'Identifier', 'StatusLine', 'StatusLineNC', '@markup.heading.gitcommit' }
)
hi('Special', { fg = cs.black, bg = 'none' })
hi('NonText', { fg = cs.black }, { 'Whitespace' })
hi('Question', { fg = cs.black })
hi('Search', { reverse = true }, { 'IncSearch', 'Visual', 'MatchParen' })
hi('Pmenu', { bg = cs.white })
hi('PmenuSel', { reverse = true })
hi('ModeMsg', { fg = cs.black })
hi('WinBar', { fg = cs.black, bg = cs.white }, { 'WinBarNC' })

tshi('Boolean', { fg = cs.blue }, { '@constant.builtin', 'Number' })
tshi('Comment', { fg = cs.grey })
tshi('Constant', { fg = cs.black })
tshi('Define', { fg = cs.black })
tshi('Function', { fg = cs.green }, { '@function.builtin', '@function.macro' })
tshi('Include', { fg = cs.black })
tshi('Keyword', { fg = cs.red }, { 'Statement' })
tshi('Namespace', { fg = cs.black })
tshi(
    'Operator',
    { fg = cs.black },
    { '@keyword.operator', '@conditional.ternary' }
)
hi('Delimiter', { none = true })
hi('@punctuation.delimiter', { fg = cs.light_black })
tshi('PreProc', { fg = cs.black })
tshi('String', { fg = cs.yellow }, { '@character' })
hi('@string.escape', { fg = cs.black })
tshi('Title', { bold = true, fg = cs.black })
tshi('Variable', { none = true }, { '@constant.python' })

tshi('Type', { fg = cs.black })
hi('@lsp.type.comment', { none = true }, { '@lsp.type.macro' })

hi('@text.emphasis', { italic = true })
hi('@text.strong', { bold = true })
hi('@text.underline', { underline = true })
hi('@text.uri', { fg = cs.blue, underline = true }, { '@text.reference' })
hi('@text.danger', { fg = cs.red, bold = true, italic = true })
hi('@text.note', { fg = cs.green, bold = true, italic = true })
hi('@text.todo', { fg = cs.blue, bold = true, italic = true }, { 'Todo' })
hi('@text.warning', { fg = cs.yellow, bold = true, italic = true })

hi('LspInlayHint', { fg = cs.grey })
hi(
    'DiagnosticError',
    { fg = cs.red },
    { 'DiagnosticFloatingError', 'DiagnosticSignError' }
)
hi(
    'DiagnosticWarn',
    { fg = cs.yellow },
    { 'DiagnosticFloatingWarn', 'DiagnosticSignWarn' }
)
hi(
    'DiagnosticHint',
    { fg = cs.magenta },
    { 'DiagnosticFloatingHint', 'DiagnosticSignHint' }
)
hi(
    'DiagnosticOk',
    { fg = cs.green },
    { 'DiagnosticFloatingOk', 'DiagnosticSignOk' }
)
hi(
    'DiagnosticInfo',
    { fg = cs.blue },
    { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' }
)
hi('DiagnosticUnderlineError', { undercurl = true, special = cs.red })
hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.yellow })
hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.magenta })
hi('DiagnosticUnderlineOk', { undercurl = true, special = cs.green })
hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.blue })

hi('@attribute.diff', { fg = cs.black })
hi('DiffAdd', { fg = cs.green }, { 'Added', '@text.diff.add', 'diffAdded' })
hi(
    'DiffDelete',
    { fg = cs.red },
    { 'Removed', '@text.diff.delete', 'diffRemoved' }
)
hi('DiffChange', { fg = cs.blue })

-- gitsigns.nvim
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.grey })
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
