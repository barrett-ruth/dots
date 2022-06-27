vim.cmd [[
    highlight clear
    if exists('syntax_on')
    syntax reset
    en
]]

local utils = require 'utils'
local cs, hi, link = utils.cs, utils.hi, utils.link

-- Setup {{{ X
vim.g.colors_name = 'gruvbox'

vim.g.terminal_ansi_colors = {
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
-- }}}

-- Basic UI {{{
hi('Normal', { fg = cs.white, bg = cs.bg })
hi('NonText', { fg = cs.black })

hi('ErrorMsg', { bold = true, underline = true, fg = cs.red, bg = 'NONE' })
hi('MoreMsg', { bold = true, fg = cs.yellow })
hi('WarningMsg', { bold = true, fg = cs.yellow })

-- Line numbers {{{ X
hi('LineNr', { fg = cs.black })
hi('CursorLineNr', { none = true, fg = cs.grey })
hi('CursorLine', { bg = cs.light_grey })
-- }}}

-- Folds/Columns {{{ X
hi('ColorColumn', { bg = cs.light_grey })
hi('SignColumn', { bg = cs.bg })
hi('FoldColumn', { bg = cs.bg })
hi('Folded', { fg = cs.grey, bg = cs.light_grey })
-- }}}

hi('VertSplit', { fg = cs.black })
hi('MatchParen', { bg = cs.grey_white })

hi('NormalFloat', { bg = 'NONE' })
hi('Visual', { bg = cs.grey_white })
hi('Whitespace', { fg = cs.black })

hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')

hi('Title', { bold = true, fg = cs.orange })
hi('Question', { none = true, fg = cs.yellow })
hi('Special', { fg = cs.yellow })
hi('Statement', { italic = true, fg = cs.red })
hi('Identifier', { fg = cs.blue })
hi('Todo', { italic = true, fg = cs.purple, bg = 'NONE' })

hi('helpNote', { bold = true, fg = cs.purple })
hi('helpExample', { none = true, fg = cs.green })
hi('helpCommand', { fg = cs.cyan })
hi('SpecialKey', { fg = cs.black })
-- }}}

-- Completion {{{ X

-- Pmenu {{{ X
hi('Pmenu', { bg = cs.grey_white })
hi('PmenuSel', { fg = cs.grey_white, bg = cs.hi })
hi('PmenuSbar', { bg = cs.grey_white })
hi('PmenuThumb', { bg = cs.hi })
-- }}}

-- nvim-cmp {{{ X
hi('CmpItemAbbrMatch', { bold = true, fg = cs.green })
hi('CmpItemAbbrMatchFuzzy', { bold = true, fg = cs.green })
hi('markdownUrl', { underline = true, fg = cs.blue })
hi('markdownLinkText', { fg = cs.purple })
-- }}}

-- }}}

-- Nvim-tree {{{ X
hi('NvimTreeIndentMarker', { fg = cs.grey })
hi('Directory', { fg = cs.orange })
link('Directory', 'NvimTreeFolderName')
-- }}}

-- LSP/Diagnostics {{{ X
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
-- }}}

-- Diffs {{{ X
hi('DiffAdd', { bg = '#34381b' })
hi('DiffChange', { bg = '#0e363e' })
hi('DiffDelete', { none = true, fg = cs.white, bg = '#402120' })
hi('DiffText', { none = true, fg = cs.bg, bg = cs.blue })
hi('diffAdded', { fg = cs.green })
hi('diffFile', { fg = cs.cyan })
hi('diffLine', { fg = cs.grey })
hi('diffOldFile', { fg = cs.yellow })
hi('diffNewFile', { fg = cs.orange })
hi('diffIndexLine', { fg = cs.purple })
-- }}}

-- Gitsigns {{{ X
hi('GitSignsAdd', { fg = cs.green })
hi('GitSignsChange', { fg = cs.blue })
hi('GitSignsDelete', { fg = cs.red })
-- }}}

-- Spelling {{{ X
hi('SpellBad', { undercurl = true, special = cs.red })
hi('SpellRare', { undercurl = true, special = cs.purple })
hi('SpellCap', { undercurl = true, special = cs.blue })
hi('SpellLocal', { undercurl = true, special = cs.cyan })
-- }}}

-- Treesitter {{{

-- Comments {{{
hi('Comment', { italic = true, fg = cs.grey })
link('Comment', 'TSComment')
-- }}}

-- Booleans {{{ X
hi('Boolean', { fg = cs.cyan })
link('Boolean', 'TSBoolean')
-- }}}

-- Constants {{{ X
hi('Constant', { fg = cs.white })
link('Constant', 'TSConstant')
hi('TSConstBuiltin', { fg = cs.purple })
-- }}}

-- Strings {{{ X
hi('String', { fg = cs.yellow })
link('String', 'TSString')
hi('TSStringEscape', { fg = cs.green })
-- }}}

-- Operators {{{ X
hi('Operator', { fg = cs.orange })
link('Operator', 'TSOperator')
link('Operator', 'TSKeywordOperator')
-- }}}

-- Types {{{ X
hi('Type', { none = true, fg = cs.cyan })
link('Type', 'TSType')
hi('TSTypeBuiltin', { fg = cs.blue })
-- }}}

-- Functions {{{ X
hi('Function', { fg = cs.green })
link('Function', 'TSFunction')
link('Function', 'TSMethod')
hi('TSFuncBuiltin', { fg = cs.green })
-- }}}

-- Macros {{{ X
hi('Macro', { fg = cs.green })
link('Macro', 'TSFuncMacro')
hi('TSConstMacro', { italic = true, fg = cs.red })
hi('PreProc', { fg = cs.purple })
-- }}}

-- Keywords {{{ X
hi('Keyword', { italic = true, fg = cs.red })
link('Keyword', 'TSKeywordFunction')
hi('TSConditional', { italic = true, fg = cs.red })
hi('TSRepeat', { italic = true, fg = cs.red })
-- }}}

-- Numbers {{{ X
hi('Number', { fg = cs.purple })
link('Number', 'TSNumber')
-- }}}

-- Variables {{{ X
hi('TSParameter', { fg = cs.white })
hi('TSVariable', { fg = cs.white })
hi('TSVariableBuiltin', { fg = cs.purple })
-- }}}

-- Includes {{{ X
hi('Include', { italic = true, fg = cs.red })
link('Include', 'TSInclude')
-- }}}

-- Punctuation {{{ X
hi('TSPunctDelimiter', { fg = cs.grey })
hi('TSPunctBracket', { fg = cs.white })
-- }}}

-- Fields {{{ X
hi('TSProperty', { fg = cs.white })
hi('TSField', { fg = cs.white })
-- }}}

-- Misc/Custom {{{
hi('TSConstructor', { fg = cs.cyan })
hi('TSNamespace', { fg = cs.cyan })
hi('TSLocal', { fg = cs.red })
hi('TSSelf', { italic = true, fg = cs.purple })
-- }}}

-- }}}

-- Language-specific highlights {{{

-- C/C++ {{{
hi('cTSType', { fg = cs.blue })
hi('cppTSType', { fg = cs.blue })
hi('cTSBoolean', { fg = cs.purple })
hi('cppTSBoolean', { fg = cs.purple })
-- }}}

-- Type/Javascript {{{
hi('TSDeclaration', { fg = cs.orange })
hi('javascriptTSBoolean', { fg = cs.purple })
hi('typescriptTSBoolean', { fg = cs.purple })
hi('typescriptTSKeywordOperator', { italic = true, fg = cs.red })
hi('javascriptTSKeywordOperator', { italic = true, fg = cs.red })
hi('typescriptTSInclude', { italic = true, fg = cs.purple })
hi('javascriptTSInclude', { italic = true, fg = cs.purple })
-- }}}

-- }}}

-- Links {{{
-- highlight! link CursorColumn ColorColumn
-- highlight! link CursorLine ColorColumn
-- highlight! link DiffAdded DiffAdd
-- highlight! link DiffRemoved DiffDelete
-- highlight! link EndOfBuffer Whitespace
-- highlight! link FoldColumn LineNr
-- highlight! link LspDiagnosticsDefaultError DiagnosticError
-- highlight! link LspDiagnosticsDefaultHint DiagnosticHint
-- highlight! link LspDiagnosticsDefaultInformation DiagnosticInfo
-- highlight! link LspDiagnosticsDefaultWarning DiagnosticWarn
-- highlight! link LspReferenceRead Visual
-- highlight! link LspReferenceText Visual
-- highlight! link LspReferenceWrite Visual
-- highlight! link NonText Whitespace
-- highlight! link Pmenu NormalFloat
-- highlight! link PmenuSbar Pmenu
-- highlight! link PmenuThumb PmenuSel
-- highlight! link Question MoreMsg
-- highlight! link SignColumn LineNr
-- highlight! link SignifySignAdd GitSignsAdd
-- highlight! link SignifySignChange GitSignsChange
-- highlight! link SignifySignDelete GitSignsDelete
-- highlight! link SpecialKey Whitespace
-- highlight! link StatusLine NormalFloat
-- highlight! link TSConstMacro Constant
-- highlight! link TSEmphasis Italic
-- highlight! link TSEnvironment Statement
-- highlight! link TSEnvironmentName PreProc
-- highlight! link TSFuncBuiltin Function
-- highlight! link TSFuncMacro Function
-- highlight! link TSKeywordFunction PreProc
-- highlight! link TSUnderline Underlined
-- highlight! link TSVariable Identifier
-- }}}

-- vim: set sw=2 fdm=marker fmr={{{,}}}
