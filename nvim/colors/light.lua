local colors = require('colors')
colors.setup('light', 'light')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('Normal', { fg = cs.black, bg = cs.bg }, { 'Identifier', 'Special' })
hi('NonText', { fg = cs.grey })
hi('LineNr', { fg = cs.grey }, { 'SignColumn' })
hi('CursorLineNr', { fg = cs.black }, { 'FoldColumn' })
hi('CursorLine', { bg = cs.light_grey }, { 'ColorColumn' })
hi('Visual', { reverse = true }, { 'Search', 'IncSearch' })

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
hi('StatusLine', { none = true })

tshi('Constructor', { fg = cs.orange })
tshi('Function', { fg = cs.purple }, { '@function.macro' })
tshi('Include', { fg = cs.red }, { '@keyword.directive.define' })
tshi('Keyword', { fg = cs.red })
tshi('Number', { fg = cs.blue })
tshi('Operator', { fg = cs.blue })
tshi('PreProc', { none = true })
tshi('String', { fg = cs.dark_blue }, { '@string.escape' })
tshi('Title', { fg = cs.blue, bold = true })
tshi('Variable', { fg = cs.black })
hi('Delimiter', { fg = cs.black }, { '@punctuation.delimiter' })

tshi('Type', { fg = cs.orange }, { '@type.builtin' })
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
hi(
    'DiffAdd',
    { fg = cs.green, bg = cs.bright_green },
    { '@text.diff.add', 'diffAdded', 'GitSignsAdd' }
)
hi(
    'DiffDelete',
    { fg = cs.red, bg = cs.bright_red },
    { '@text.diff.delete', 'diffRemoved', 'GitSignsDelete' }
)
hi('DiffChange', { fg = cs.dark_blue, bg = cs.blue }, { 'GitSignsChange' })

-- language-specific
hi('jsonKeyword', { fg = cs.green })

-- gitsigns.nvim
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.light_black })

-- null-ls
link('NormalFloat', 'NullLsInfoBorder')

-- oil.nvim
link('Directory', 'OilDir')
