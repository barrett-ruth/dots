if vim.g.colors_name then vim.cmd 'hi clear' end

local utils = require 'utils'
local cs, hi, link = utils.cs, utils.hi, utils.link

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

-- basic ui [:
hi('Normal', { fg = cs.white, bg = cs.bg })
hi('NonText', { fg = cs.black })

-- messages [:
hi('ErrorMsg', { bold = true, underline = true, fg = cs.red, bg = 'NONE' })
hi('MoreMsg', { bold = true, fg = cs.yellow })
hi('WarningMsg', { bold = true, fg = cs.yellow })
-- :]

-- line numbers [:
hi('LineNr', { fg = cs.black })
hi('CursorLineNr', { none = true, fg = cs.grey })
hi('CursorLine', { bg = cs.light_grey })
-- :]

-- folds/Columns [:
hi('ColorColumn', { bg = cs.light_grey })
hi('SignColumn', { bg = cs.bg })
hi('FoldColumn', { bg = cs.bg })
hi('Folded', { fg = cs.grey, bg = cs.light_grey })
-- :]

-- health [:
hi('HealthSuccess', { fg = cs.green })
hi('HealthWarning', { fg = cs.yellow })
hi('HealthError', { fg = cs.red })
-- :]

-- help [:
hi('helpNote', { bold = true, fg = cs.purple })
hi('helpExample', { none = true, fg = cs.green })
hi('helpCommand', { fg = cs.cyan })
hi('SpecialKey', { fg = cs.black })
-- :]

hi('VertSplit', { fg = cs.black })
hi('MatchParen', { bg = cs.grey_white })

hi('NormalFloat', { bg = 'NONE' })
hi('Visual', { bg = cs.grey_white })
hi('Whitespace', { fg = cs.black })

hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')

hi('Error', { fg = cs.red })
hi('Title', { bold = true, fg = cs.orange })
hi('Question', { none = true, fg = cs.yellow })
hi('Special', { fg = cs.yellow })
hi('Statement', { italic = true, fg = cs.red })
hi('Statusline', { none = true })
hi('Identifier', { fg = cs.blue })
-- :]

-- pmenu [:
hi('Pmenu', { bg = cs.grey_white })
hi('PmenuSel', { fg = cs.grey_white, bg = cs.hi })
hi('PmenuSbar', { bg = cs.grey_white })
hi('PmenuThumb', { bg = cs.hi })
-- :]

-- nvim-cmp [:
hi('CmpItemAbbrMatch', { fg = cs.green })
hi('CmpItemAbbrMatchFuzzy', { fg = cs.green })
-- :]

-- vim-highlighturl [:
hi('HighlightUrl', { fg = cs.blue, italic = true })
-- :]

-- nvim-tree [:
hi('NvimTreeIndentMarker', { fg = cs.grey })
hi('Directory', { fg = cs.orange })
link('Directory', 'NvimTreeFolderName')
-- :]

-- fzf-lua [:
link('Normal', 'FzfLuaBorder')
-- :]

-- lsp/diagnostics [:
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
-- :]

-- diffs [:
hi('DiffAdd', { fg = cs.green, reverse = true })
hi('DiffChange', { fg = cs.blue, reverse = true })
hi('DiffDelete', { fg = cs.red, reverse = true })
-- hi('DiffText', { none = true, fg = cs.bg, bg = cs.blue })
hi('diffAdded', { fg = cs.green })
hi('diffRemoved', { fg = cs.red })
hi('diffFile', { fg = cs.cyan })
hi('diffLine', { fg = cs.grey })
hi('diffOldFile', { fg = cs.yellow })
hi('diffNewFile', { fg = cs.orange })
hi('diffIndexLine', { fg = cs.purple })
-- :]

-- gitsigns [:
hi('GitSignsAdd', { fg = cs.green })
hi('GitSignsChange', { fg = cs.blue })
hi('GitSignsDelete', { fg = cs.red })
-- :]

-- spelling [:
hi('SpellBad', { undercurl = true, special = cs.red })
hi('SpellRare', { undercurl = true, special = cs.purple })
hi('SpellCap', { undercurl = true, special = cs.blue })
hi('SpellLocal', { undercurl = true, special = cs.cyan })
-- :]

-- treesitter [:

-- comments
hi('Comment', { italic = true, fg = cs.grey })
link('Comment', 'TSComment')

hi('TSWarning', { fg = cs.purple, bold = true })
hi('TSDanger', { fg = cs.yellow, bold = true })

-- booleans [:
hi('Boolean', { fg = cs.cyan })
link('Boolean', 'TSBoolean')
-- :]

-- constants [:
hi('Constant', { fg = cs.white })
link('Constant', 'TSConstant')
hi('TSConstBuiltin', { fg = cs.purple })
-- :]

-- strings [:
hi('String', { fg = cs.yellow })
link('String', 'TSString')
hi('TSStringEscape', { fg = cs.green })
-- :]

-- operators [:
hi('Operator', { fg = cs.orange })
link('Operator', 'TSOperator')
link('Operator', 'TSKeywordOperator')
-- :]

-- types [:
hi('Type', { none = true, fg = cs.cyan })
link('Type', 'TSType')
hi('TSTypeBuiltin', { fg = cs.blue })
-- :]

-- functions [:
hi('Function', { fg = cs.green })
link('Function', 'TSFunction')
link('Function', 'TSMethod')
hi('TSFuncBuiltin', { fg = cs.green })
-- :]

-- macros [:
hi('Macro', { fg = cs.green })
link('Macro', 'TSFuncMacro')
hi('TSConstMacro', { italic = true, fg = cs.red })
hi('PreProc', { fg = cs.purple })
-- :]

-- keywords [:
hi('Keyword', { italic = true, fg = cs.red })
link('Keyword', 'TSKeywordFunction')
hi('TSConditional', { italic = true, fg = cs.red })
hi('TSRepeat', { italic = true, fg = cs.red })
-- :]

-- numbers [:
hi('Number', { fg = cs.purple })
link('Number', 'TSNumber')
-- :]

-- variables [:
hi('TSParameter', { fg = cs.white })
hi('TSVariable', { fg = cs.white })
hi('TSVariableBuiltin', { fg = cs.purple })
-- :]

-- includes [:
hi('Include', { italic = true, fg = cs.red })
link('Include', 'TSInclude')
-- :]

-- punctuation [:
hi('TSPunctDelimiter', { fg = cs.grey })
hi('TSPunctBracket', { fg = cs.white })
-- :]

-- fields [:
hi('TSProperty', { fg = cs.white })
hi('TSField', { fg = cs.white })
-- :]

-- misc [:
hi('TSConstructor', { fg = cs.cyan })
hi('TSDeclaration', { fg = cs.orange })
hi('TSNamespace', { fg = cs.cyan })
hi('TSTag', { fg = cs.orange })
hi('StorageClass', { fg = cs.cyan })
link('StorageClass', 'TSStorageClass')
link('StorageClass', 'TSClass')
link('StorageClass', 'TSStruct')
hi('TSEnum', { fg = cs.purple })
hi('TSTagDelimiter', { fg = cs.green })
hi('TSURI', { fg = cs.green })
hi('TSTextReference', { fg = cs.blue })
-- :]

-- language-specific highlights [:

-- c/c++ [:
hi('cTSType', { fg = cs.blue })
hi('cppTSType', { fg = cs.blue })
hi('cTSBoolean', { fg = cs.purple })
hi('cppTSBoolean', { fg = cs.purple })
-- :]

-- type/javascript [:
hi('javascriptTSBoolean', { fg = cs.purple })
hi('typescriptTSBoolean', { fg = cs.purple })
hi('javascriptTSKeywordOperator', { italic = true, fg = cs.red })
hi('typescriptTSKeywordOperator', { italic = true, fg = cs.red })
hi('typescriptTSInclude', { italic = true, fg = cs.purple })
hi('javascriptTSInclude', { italic = true, fg = cs.purple })
-- :]

-- :]
-- :]
