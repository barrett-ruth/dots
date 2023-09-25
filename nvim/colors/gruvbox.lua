local colors = require('colors')
colors.setup('gruvbox', 'dark')

local hi, link, tshi, cs =
    colors.hi, colors.link, colors.tshi, colors[vim.g.colors_name]

hi('Normal', { fg = cs.white, bg = cs.bg }, { 'Identifier', 'Special' })
hi('NonText', { fg = cs.grey }, { 'SpecialKey' })

hi('LineNr', { fg = cs.grey }, { 'SignColumn' })
hi('CursorLine', { bg = cs.dark_grey }, { 'ColorColumn', 'Folded' })
hi('CursorLineNr', { fg = cs.light_black }, { 'FoldColumn' })

hi('Conceal', { fg = cs.grey, bg = cs.bg })
hi('Directory', { fg = cs.yellow })
hi('Error', { fg = cs.red })
hi('ErrorMsg', { bold = true, underline = true, fg = cs.red })
hi('MoreMsg', { bold = true, fg = cs.yellow }, { 'WarningMsg' })
hi('MatchParen', { bg = cs.med_grey })
hi('NormalFloat', { bg = cs.bg }, {
    'LspInfoBorder',
    'FloatBorder',
    'FloatShadow',
    'FloatShadowThrough',
})
hi('Search', { reverse = true }, { 'IncSearch' })
hi('Visual', { bg = cs.med_grey })
hi('Whitespace', { fg = cs.grey })

tshi('Boolean', { fg = cs.magenta }, { '@constant.builtin' })
tshi('Comment', { fg = cs.light_black })
tshi('Constant', { fg = cs.white })
tshi('Define', { fg = cs.magenta })
tshi('Function', { fg = cs.green }, { '@function.builtin', '@function.macro' })
tshi('Include', { fg = cs.red })
tshi('Keyword', { fg = cs.red }, { 'Statement' })
tshi('Namespace', { fg = cs.yellow })
tshi('Number', { fg = cs.magenta })
tshi(
    'Operator',
    { fg = cs.orange },
    { '@keyword.operator', '@conditional.ternary' }
)
hi('@punctuation.delimiter', { fg = cs.light_black })
tshi('PreProc', { fg = cs.magenta })
tshi('String', { fg = cs.yellow }, { '@character' })
hi('@string.escape', { fg = cs.green })
tshi('Title', { bold = true, fg = cs.green })

hi('@tag', { fg = cs.orange })
hi('@tag.attribute', { fg = cs.white })
hi('@tag.delimiter', { fg = cs.white })

tshi('Type', { fg = cs.yellow })
hi('@type.qualifier', { fg = cs.orange }, { '@storageclass' })
hi('@lsp.type.enum', { fg = cs.white }, { '@lsp.type.class' })
hi('@lsp.type.comment', { none = true }, { '@lsp.type.macro' })

hi('@text.emphasis', { italic = true })
hi('@text.strong', { bold = true })
hi('@text.underline', { underline = true })
hi('@text.uri', { fg = cs.blue, underline = true }, { '@text.reference' })

hi('@text.danger', { fg = cs.red, bold = true, italic = true })
hi('@text.note', { fg = cs.green, bold = true, italic = true })
hi('@text.todo', { fg = cs.yellow, bold = true, italic = true }, { 'Todo' })
hi('@text.warning', { fg = cs.orange, bold = true, italic = true })

hi('Pmenu', { bg = cs.med_grey }, { 'PmenuSbar' })
hi('PmenuSel', { fg = cs.med_grey, bg = cs.light_grey })
hi('PmenuThumb', { bg = cs.light_grey })

hi('LspInlayHint', { fg = cs.grey })
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
    { fg = cs.cyan },
    { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' }
)
hi('DiagnosticUnderlineError', { undercurl = true, special = cs.red })
hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.orange })
hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.magenta })
hi('DiagnosticUnderlineOk', { undercurl = true, special = cs.green })
hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.cyan })

hi('SpellBad', { underline = true, special = cs.red })
hi('SpellRare', { underline = true, special = cs.magenta })
hi('SpellCap', { underline = true, special = cs.blue })
hi('SpellLocal', { underline = true, special = cs.cyan })

hi('gitCommitSummary', { fg = cs.white })

hi('@attribute.diff', { fg = cs.magenta })
hi('DiffAdd', { fg = cs.green }, { '@text.diff.add', 'diffAdded' })
hi('DiffDelete', { fg = cs.red }, { '@text.diff.delete', 'diffRemoved' })
hi('DiffChange', { fg = cs.blue })

-- language-specific
hi('@constructor.lua', { fg = cs.white })

-- gitsigns.nvim
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.light_black })
link('DiffAdd', 'GitSignsAdd')
link('DiffChange', 'GitSignsChange')
link('DiffDelete', 'GitSignsDelete')

-- highlight-undo.nvim
link('Search', 'HighlightUndo')

-- nvim-cmp
hi('CmpItemAbbrMatch', { fg = colors[vim.g.colors_name].green })

-- nvim-ufo
hi('UfoFoldedEllipsis', { fg = colors[vim.g.colors_name].dark_grey })

-- null-ls
link('NormalFloat', 'NullLsInfoBorder')

-- oil.nvim
link('Directory', 'OilDir')

-- fzf-lua
link('NormalFloat', 'FzfLuaBorder')
hi(
    'FzfLuaHeaderText',
    { fg = colors[vim.g.colors_name].red },
    { 'FzfLuaBufFlagCur' }
)
hi('FzfLuaBufFlagAlt', { fg = colors[vim.g.colors_name].cyan })
