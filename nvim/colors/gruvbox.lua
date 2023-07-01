local colors = require('colors')
colors.setup('gruvbox', 'dark')

local hi, tshi, link, cs =
    colors.hi, colors.tshi, colors.link, colors[vim.g.colors_name]

hi('Normal', { fg = cs.white, bg = cs.bg }, { 'Identifier', 'Special' })
hi('NonText', { fg = cs.grey }, { 'SpecialKey' })

hi('LineNr', { fg = cs.grey }, { 'SignColumn', 'FoldColumn' })
hi('CursorLine', { bg = cs.dark_grey }, { 'ColorColumn' })
hi('CursorLineNr', { fg = cs.light_black })

hi('Directory', { fg = cs.yellow })
hi('ErrorMsg', { bold = true, underline = true, fg = cs.red })
hi('MoreMsg', { bold = true, fg = cs.yellow }, { 'WarningMsg' })
hi('MatchParen', { bg = cs.med_grey })
hi('NormalFloat', { bg = cs.bg }, {
    'LspInfoBorder',
    'FloatBorder',
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
tshi('String', { fg = cs.yellow })
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
hi('@text.uri', { fg = cs.blue, underline = true })

hi('@text.danger', { fg = cs.red, bold = true, italic = true })
hi('@text.note', { fg = cs.green, bold = true, italic = true })
hi('@text.todo', { fg = cs.yellow, bold = true, italic = true })
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
    { fg = cs.green },
    { 'DiagnosticFloatingHint', 'DiagnosticSignHint' }
)
hi(
    'DiagnosticInfo',
    { fg = cs.cyan },
    { 'DiagnosticFloatingInfo', 'DiagnosticSignInfo' }
)
hi('DiagnosticUnderlineError', { undercurl = true, special = cs.red })
hi('DiagnosticUnderlineWarn', { undercurl = true, special = cs.orange })
hi('DiagnosticUnderlineHint', { undercurl = true, special = cs.green })
hi('DiagnosticUnderlineInfo', { undercurl = true, special = cs.cyan })

hi('SpellBad', { underline = true, special = cs.red }, { '@spell.bad' })
hi('SpellRare', { underline = true, special = cs.magenta }, { '@spell.rare' })
hi('SpellCap', { underline = true, special = cs.blue }, { '@spell.cap' })
hi('SpellLocal', { underline = true, special = cs.cyan }, { '@spell.local' })

hi('gitCommitSummary', { fg = cs.white })

hi('@attribute.diff', { fg = cs.magenta })
hi('DiffAdd', { fg = cs.green }, { '@text.diff.add' })
hi('DiffDelete', { fg = cs.red }, { '@text.diff.delete' })
hi('DiffChange', { fg = cs.blue })

-- fzf-lua
link('NormalFloat', 'FzfLuaBorder')

-- null-ls
link('NormalFloat', 'NullLsInfoBorder')

-- gitsigns.nvim
link('DiffAdd', 'GitSignsAdd')
link('DiffChange', 'GitSignsChange')
link('DiffDelete', 'GitSignsDelete')
hi('GitSignsCurrentLineBlame', { italic = true, fg = cs.light_black })

-- nvim-cmp
hi('CmpItemAbbrMatch', { fg = cs.green })

-- oil.nvim
link('Directory', 'OilDir')
