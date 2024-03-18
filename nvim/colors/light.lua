local colors = require('colors')
colors.setup('light', 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('Normal', { fg = cs.black, bg = cs.bg }, { 'Identifier', 'Special' })
hi('NonText', { fg = cs.grey })
hi('LineNr', { fg = cs.grey }, { 'SignColumn' })
hi('CursorLineNr', { fg = cs.black }, { 'FoldColumn' })
hi('CursorLine', { bg = cs.light_grey }, { 'ColorColumn' })
hi('Search', { bg = cs.yellow })
hi('IncSearch', { bg = cs.orange })
hi('Visual', { reverse = true })

tshi('Boolean', { fg = cs.blue })
tshi('Constant', { fg = cs.blue })
tshi(
    'Comment',
    { fg = cs.dark_grey },
    { '@keyword.directive', '@string.documentation' }
)
hi('Directory', { fg = cs.blue })
hi('Error', { fg = cs.red })
hi('ErrorMsg', { fg = cs.red, bold = true, underline = true })
hi('MatchParen', { reverse = true })
hi('NormalFloat', { bg = cs.bg }, {
    'LspInfoBorder',
    'FloatBorder',
    'FloatShadow',
    'FloatShadowThrough',
})
hi('Pmenu', { fg = cs.black, bg = cs.white })
hi('PmenuSel', { fg = cs.black, bg = cs.light_grey }, { 'PmenuSbar' })
hi('PmenuThumb', { bg = cs.grey })
hi('Statement', { fg = cs.red })

tshi('Function', { fg = cs.purple }, { '@function.macro' })
tshi('Include', { fg = cs.red }, { '@keyword.directive.define' })
tshi('Keyword', { fg = cs.red })
tshi('Number', { fg = cs.blue })
tshi('Operator', { fg = cs.blue })
tshi('PreProc', { none = true })
tshi('String', { fg = cs.dark_blue }, { '@string.escape' })
tshi('Title', { fg = cs.blue, bold = true })
tshi('Variable', { fg = cs.black })
hi('@punctuation.delimiter', { fg = cs.black })

tshi('Type', { fg = cs.black }, { '@type.builtin' })
hi('@type.qualifier', { fg = cs.red })

hi('@text.danger', { fg = cs.red, bold = true, italic = true, reverse = true })
hi(
    '@text.todo',
    { fg = cs.blue, bold = true, italic = true, reverse = true },
    { 'Todo' }
)

hi('LspSignatureActiveParameter', { underline = true, italic = true })
hi(
    'DiagnosticError',
    { fg = cs.red },
    { 'DiagnosticFloatingError', 'DiagnosticSignError' }
)
hi(
    'DiagnosticWarn',
    { fg = cs.orange },
    { 'DiagnosticFloatingWarn', 'DiagnosticSignWarn' }
)
hi(
    'DiagnosticHint',
    { fg = cs.purple },
    { 'DiagnosticFloatingHint', 'DiagnosticSignHint' }
)
hi(
    'DiagnosticOk',
    { fg = cs.green },
    { 'DiagnosticFloatingOk', 'DiagnosticSignOk' }
)
hi(
    'DiagnosticInfo',
    { fg = cs.cyan },
    { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' }
)
hi('DiagnosticUnderlineError', {
    undercurl = true,
    special = cs.red,
})
hi('DiagnosticUnderlineWarn', {
    undercurl = true,
    special = cs.orange,
})
hi('DiagnosticUnderlineHint', {
    undercurl = true,
    special = cs.purple,
})
hi('DiagnosticUnderlineOk', {
    undercurl = true,
    special = cs.green,
})
hi('DiagnosticUnderlineInfo', {
    undercurl = true,
    special = cs.cyan,
})

hi('@attribute.diff', { fg = cs.purple })
hi('DiffAdd', { fg = cs.green }, { '@text.diff.add', 'diffAdded' })
hi('DiffDelete', { fg = cs.red }, { '@text.diff.delete', 'diffRemoved' })
hi('DiffChange', { fg = cs.blue })

-- language-specific
hi('jsonKeyword', { fg = cs.green })

-- gitsigns.nvim
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.light_black })
link('DiffAdd', 'GitSignsAdd')
link('DiffChange', 'GitSignsChange')
link('DiffDelete', 'GitSignsDelete')

-- null-ls
link('NormalFloat', 'NullLsInfoBorder')

-- oil.nvim
link('Directory', 'OilDir')
