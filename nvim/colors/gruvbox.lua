if vim.g.colors_name then vim.cmd.hi 'clear' end

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
hi('MatchParen', { bg = cs.dark_grey })

hi('NormalFloat', { bg = 'NONE' })
hi('Visual', { bg = cs.dark_grey })
hi('Whitespace', { fg = cs.black })

hi('Search', { fg = 'NONE', bg = 'NONE', reverse = true })
link('Search', 'IncSearch')

hi('Error', { fg = cs.red })
hi('Question', { none = true, fg = cs.yellow })
hi('Special', { fg = cs.yellow })
hi('Statement', { italic = true, fg = cs.red })
hi('Statusline', { none = true })
hi('Identifier', { fg = cs.blue })
-- :]

-- pmenu [:
hi('Pmenu', { bg = cs.dark_grey })
hi('PmenuSel', { fg = cs.dark_grey, bg = cs.hi })
hi('PmenuSbar', { bg = cs.dark_grey })
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
hi('Directory', { fg = cs.light_blue })
link('Directory', 'NvimTreeFolderName')
hi('NvimTreeRootFolder', { fg = cs.cyan })
hi(
    'NvimTreeSpecialFile',
    { bold = true, fg = cs.light_yellow, underline = true }
)
hi('NvimTreeExecFile', { bold = true, fg = cs.light_green })
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
hi('SpellBad', { underline = true, special = cs.red })
hi('SpellRare', { underline = true, special = cs.purple })
hi('SpellCap', { underline = true, special = cs.blue })
hi('SpellLocal', { underline = true, special = cs.cyan })
-- :]

-- treesitter [:

link('Visual', 'TreesitterContext')

-- Spelling [:
link('SpellBad', '@spell.bad')
link('SpellRare', '@spell.rare')
link('SpellCap', '@spell.cap')
link('SpellLocal', '@spell.local')
-- :]

-- comments
hi('Comment', { italic = true, fg = cs.grey })
link('Comment', '@comment')

-- text [:
hi('@todo', { fg = cs.purple, bold = true })
hi('@text.warning', { fg = cs.yellow, bold = true })
hi('Title', { bold = true, fg = cs.orange })
link('Title', '@text.title')
hi('@text.strong', { bold = true })
hi('@text.uri', { fg = cs.blue })
hi('@text.reference', { fg = cs.blue })
-- :]

-- booleans [:
hi('Boolean', { fg = cs.cyan })
link('Boolean', '@boolean')
-- :]

-- constants [:
hi('Constant', { fg = cs.white })
link('Constant', '@constant')
hi('@constant.builtin', { fg = cs.purple })
hi('@constant.macro', { italic = true, fg = cs.red })
-- :]

-- strings [:
hi('String', { fg = cs.yellow })
link('String', '@string')
hi('@string.escape', { fg = cs.green })
-- :]

-- operators [:
hi('Operator', { fg = cs.orange })
link('Operator', '@operator')
link('Operator', '@keyword.operator')
-- :]

-- types [:
hi('Type', { none = true, fg = cs.cyan })
link('Type', '@type')
hi('@type.builtin', { fg = cs.blue })
-- :]

-- functions [:
hi('Function', { fg = cs.green })
link('Function', '@function')
link('Function', '@method')
hi('@function.builtin', { fg = cs.green })
-- :]

-- macros [:
hi('@macro', { fg = cs.green })
link('@macro', '@function.macro')
hi('PreProc', { fg = cs.purple })
link('PreProc', '@preproc')
-- :]

-- keywords [:
hi('Keyword', { italic = true, fg = cs.red })
link('Keyword', '@keyword')
link('Keyword', '@keyword.function')
hi('@conditional', { italic = true, fg = cs.red })
hi('@repeat', { italic = true, fg = cs.red })
-- :]

-- numbers [:
hi('Number', { fg = cs.purple })
link('Number', '@number')
-- :]

-- variables [:
hi('@parameter', { fg = cs.white })
hi('@variable', { fg = cs.white })
hi('@variable.builtin', { fg = cs.purple })
-- :]

-- includes [:
hi('Include', { italic = true, fg = cs.red })
link('Include', '@include')
-- :]

-- punctuation [:
hi('@punctuation', { fg = cs.grey })
link('@punctuation', '@punctuation.delimiter')
hi('@punctuation.bracket', { fg = cs.white })
hi('@punctuation.special', { fg = cs.green })
-- :]

-- fields [:
hi('@property', { fg = cs.white })
hi('@field', { fg = cs.white })
-- :]

-- misc [:
hi('@constructor', { fg = cs.cyan })
hi('@declaration', { fg = cs.orange })
hi('@namespace', { fg = cs.cyan })
hi('StorageClass', { fg = cs.cyan })

link('StorageClass', '@storageclass')
link('StorageClass', '@class')
link('StorageClass', '@struct')
hi('@enum', { fg = cs.purple })

hi('@tag', { fg = cs.orange })
hi('@tag.delimiter', { fg = cs.green })

-- :]

-- language-specific highlights [:

-- c/c++ [:
hi('cType', { fg = cs.blue })
hi('cppType', { fg = cs.blue })
hi('cBoolean', { fg = cs.purple })
hi('cppBoolean', { fg = cs.purple })
-- :]

-- type/javascript [:
hi('javascriptBoolean', { fg = cs.purple })
hi('typescriptBoolean', { fg = cs.purple })
hi('javascriptKeywordOperator', { italic = true, fg = cs.red })
hi('typescriptKeywordOperator', { italic = true, fg = cs.red })
hi('typescriptInclude', { italic = true, fg = cs.purple })
hi('javascriptInclude', { italic = true, fg = cs.purple })
-- :]

-- :]
-- :]
