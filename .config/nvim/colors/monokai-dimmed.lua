-- monokai-dimmed.lua
-- A Neovim colorscheme inspired by VS Code's Monokai Dimmed theme.
-- Place in ~/.config/nvim/colors/monokai-dimmed.lua
-- Usage: colorscheme monokai-dimmed

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.o.background = "dark"
vim.g.colors_name = "monokai-dimmed"

local c = {
  -- Backgrounds
  bg0        = "#262626",  -- editor background
  bg1        = "#2d2d2d",  -- subtle raised surface (float, popup)
  bg2        = "#303030",  -- sidebar / panels
  bg3        = "#3a3a3a",  -- selection / visual / line highlight
  bg4        = "#4a4a4a",  -- borders / dividers

  -- Foregrounds
  fg0        = "#d4d4d4",  -- identifiers (brightest)
  fg1        = "#c8c8c8",  -- default text
  fg2        = "#a0a0a0",  -- dimmed text
  fg3        = "#6c6c6c",  -- comments / very muted

  -- Syntax colors
  red        = "#d16969",  -- keywords, tags
  orange     = "#ce9178",  -- strings, attributes
  yellow     = "#d7ba7d",  -- classes, types, constants
  green      = "#6a9955",  -- comments (alt), diffs added
  green      = "#476639",  -- // new green test
  cyan       = "#4ec9b0",  -- functions, methods
  blue       = "#569cd6",  -- variables, properties
  purple     = "#c586c0",  -- control flow, builtins

  -- Diagnostics / Git
  err        = "#f44747",
  warn       = "#cca700",
  info       = "#75beff",
  hint       = "#4ec9b0",

  git_add    = "#6a9955",
  git_change = "#569cd6",
  git_del    = "#d16969",

  none       = "NONE",
}

-- Helper
local function hi(group, opts)
  local fg   = opts.fg   or c.none
  local bg   = opts.bg   or c.none
  local sp   = opts.sp   or c.none
  local bold = opts.bold and "bold" or c.none
  local it   = opts.italic and "italic" or c.none
  local ul   = opts.underline and "underline" or c.none

  local attrs = {}
  if bold ~= c.none then table.insert(attrs, "bold") end
  if it   ~= c.none then table.insert(attrs, "italic") end
  if ul   ~= c.none then table.insert(attrs, "underline") end
  local gui = #attrs > 0 and table.concat(attrs, ",") or c.none

  vim.api.nvim_set_hl(0, group, {
    fg        = fg ~= c.none and fg or nil,
    bg        = bg ~= c.none and bg or nil,
    sp        = sp ~= c.none and sp or nil,
    bold      = opts.bold or false,
    italic    = opts.italic or false,
    underline = opts.underline or false,
  })
end

-- ─── Editor UI ────────────────────────────────────────────────────────────────

hi("Normal",          { fg = c.fg1,  bg = c.bg0 })
hi("NormalFloat",     { fg = c.fg1,  bg = c.bg1 })
hi("NormalNC",        { fg = c.fg2,  bg = c.bg0 })

hi("Cursor",          { fg = c.bg0,  bg = c.fg0 })
hi("CursorLine",      { bg = c.bg3 })
hi("CursorColumn",    { bg = c.bg3 })
hi("CursorLineNr",    { fg = c.fg0,  bg = c.bg3, bold = true })

hi("LineNr",          { fg = c.bg4 })
hi("SignColumn",      { fg = c.fg3,  bg = c.bg0 })
hi("ColorColumn",     { bg = c.bg2 })
hi("FoldColumn",      { fg = c.fg3,  bg = c.bg0 })
hi("Folded",          { fg = c.fg3,  bg = c.bg2, italic = true })

hi("StatusLine",      { fg = c.fg1,  bg = c.bg2 })
hi("StatusLineNC",    { fg = c.fg3,  bg = c.bg2 })
hi("WinBar",          { fg = c.fg2,  bg = c.bg0 })
hi("WinBarNC",        { fg = c.fg3,  bg = c.bg0 })
hi("WinSeparator",    { fg = c.bg4,  bg = c.bg0 })

hi("TabLine",         { fg = c.fg3,  bg = c.bg2 })
hi("TabLineFill",     { fg = c.fg3,  bg = c.bg2 })
hi("TabLineSel",      { fg = c.fg0,  bg = c.bg0, bold = true })

hi("Pmenu",           { fg = c.fg1,  bg = c.bg1 })
hi("PmenuSel",        { fg = c.fg0,  bg = c.bg3, bold = true })
hi("PmenuSbar",       { bg = c.bg2 })
hi("PmenuThumb",      { bg = c.bg4 })

hi("Visual",          { bg = c.bg3 })
hi("VisualNOS",       { bg = c.bg3 })

hi("Search",          { fg = c.bg0,  bg = c.yellow })
hi("IncSearch",       { fg = c.bg0,  bg = c.cyan,   bold = true })
hi("CurSearch",       { fg = c.bg0,  bg = c.cyan,   bold = true })
hi("Substitute",      { fg = c.bg0,  bg = c.orange })

hi("MatchParen",      { fg = c.cyan, bg = c.bg3,    bold = true })

hi("NonText",         { fg = c.bg4 })
hi("Whitespace",      { fg = c.bg4 })
hi("SpecialKey",      { fg = c.bg4 })
hi("EndOfBuffer",     { fg = c.bg2 })

hi("Directory",       { fg = c.blue })
hi("Title",           { fg = c.yellow, bold = true })
hi("Question",        { fg = c.cyan })
hi("MoreMsg",         { fg = c.cyan })
hi("ModeMsg",         { fg = c.fg0,  bold = true })
hi("ErrorMsg",        { fg = c.err })
hi("WarningMsg",      { fg = c.warn })

hi("Conceal",         { fg = c.fg3 })
hi("SpellBad",        { sp = c.err,  underline = true })
hi("SpellCap",        { sp = c.warn, underline = true })
hi("SpellRare",       { sp = c.hint, underline = true })
hi("SpellLocal",      { sp = c.info, underline = true })

-- ─── Syntax ───────────────────────────────────────────────────────────────────

hi("Comment",         { fg = c.green,  italic = true })
hi("SpecialComment",  { fg = c.green,  bold = true })
hi("Todo",            { fg = c.yellow, bold = true })

hi("Constant",        { fg = c.yellow })
hi("String",          { fg = c.orange })
hi("Character",       { fg = c.orange })
hi("Number",          { fg = c.yellow })
hi("Boolean",         { fg = c.blue })
hi("Float",           { fg = c.yellow })

hi("Identifier",      { fg = c.fg0 })
hi("Function",        { fg = c.cyan })

hi("Statement",       { fg = c.red })
hi("Conditional",     { fg = c.purple })
hi("Repeat",          { fg = c.purple })
hi("Label",           { fg = c.purple })
hi("Operator",        { fg = c.fg1 })
hi("Keyword",         { fg = c.red })
hi("Exception",       { fg = c.purple })

hi("PreProc",         { fg = c.red })
hi("Include",         { fg = c.purple })
hi("Define",          { fg = c.red })
hi("Macro",           { fg = c.red })
hi("PreCondit",       { fg = c.purple })

hi("Type",            { fg = c.yellow })
hi("StorageClass",    { fg = c.blue })
hi("Structure",       { fg = c.yellow })
hi("Typedef",         { fg = c.yellow })

hi("Special",         { fg = c.orange })
hi("SpecialChar",     { fg = c.orange })
hi("Tag",             { fg = c.red })
hi("Delimiter",       { fg = c.fg2 })
hi("Debug",           { fg = c.orange })

hi("Underlined",      { fg = c.blue, underline = true })
hi("Error",           { fg = c.err })
hi("Ignore",          { fg = c.fg3 })

-- ─── Treesitter ───────────────────────────────────────────────────────────────

hi("@comment",                 { fg = c.green,  italic = true })
hi("@comment.documentation",   { fg = c.green,  italic = true })
hi("@comment.todo",            { fg = c.yellow, bold = true })

hi("@constant",                { fg = c.yellow })
hi("@constant.builtin",        { fg = c.blue })
hi("@constant.macro",          { fg = c.red })

hi("@string",                  { fg = c.orange })
hi("@string.escape",           { fg = c.cyan })
hi("@string.special",          { fg = c.cyan })
hi("@string.regex",            { fg = c.cyan })

hi("@character",               { fg = c.orange })
hi("@number",                  { fg = c.yellow })
hi("@number.float",            { fg = c.yellow })
hi("@boolean",                 { fg = c.blue })

hi("@function",                { fg = c.cyan })
hi("@function.call",           { fg = c.cyan })
hi("@function.builtin",        { fg = c.cyan })
hi("@function.macro",          { fg = c.red })
hi("@function.method",         { fg = c.cyan })
hi("@function.method.call",    { fg = c.cyan })

hi("@constructor",             { fg = c.yellow })
hi("@operator",                { fg = c.fg1 })

hi("@keyword",                 { fg = c.red })
hi("@keyword.function",        { fg = c.purple })
hi("@keyword.operator",        { fg = c.red })
hi("@keyword.return",          { fg = c.purple })
hi("@keyword.conditional",     { fg = c.purple })
hi("@keyword.repeat",          { fg = c.purple })
hi("@keyword.exception",       { fg = c.purple })
hi("@keyword.import",          { fg = c.purple })
hi("@keyword.type",            { fg = c.yellow })
hi("@keyword.modifier",        { fg = c.blue })

hi("@variable",                { fg = c.fg1 })
hi("@variable.builtin",        { fg = c.blue })
hi("@variable.member",         { fg = c.blue })
hi("@variable.parameter",      { fg = c.fg0 })
hi("@variable.parameter.builtin", { fg = c.blue })

hi("@type",                    { fg = c.yellow })
hi("@type.builtin",            { fg = c.blue })
hi("@type.definition",         { fg = c.yellow })
hi("@type.qualifier",          { fg = c.blue })

hi("@namespace",               { fg = c.fg0 })
hi("@module",                  { fg = c.fg0 })
hi("@label",                   { fg = c.orange })
hi("@attribute",               { fg = c.orange })

hi("@tag",                     { fg = c.red })
hi("@tag.builtin",             { fg = c.red })
hi("@tag.attribute",           { fg = c.orange })
hi("@tag.delimiter",           { fg = c.fg2 })

hi("@markup.heading",          { fg = c.yellow, bold = true })
hi("@markup.heading.1",        { fg = c.red,    bold = true })
hi("@markup.heading.2",        { fg = c.orange, bold = true })
hi("@markup.heading.3",        { fg = c.yellow, bold = true })
hi("@markup.heading.4",        { fg = c.cyan,   bold = true })
hi("@markup.heading.5",        { fg = c.blue,   bold = true })
hi("@markup.heading.6",        { fg = c.purple, bold = true })
hi("@markup.italic",           { fg = c.fg1,  italic = true })
hi("@markup.strong",           { fg = c.fg0,  bold = true })
hi("@markup.underline",        { fg = c.fg1,  underline = true })
hi("@markup.strikethrough",    { fg = c.fg3 })
hi("@markup.link",             { fg = c.blue, underline = true })
hi("@markup.link.url",         { fg = c.blue, underline = true })
hi("@markup.link.label",       { fg = c.cyan })
hi("@markup.raw",              { fg = c.orange })
hi("@markup.raw.block",        { fg = c.orange })
hi("@markup.list",             { fg = c.red })
hi("@markup.list.checked",     { fg = c.green })
hi("@markup.list.unchecked",   { fg = c.fg3 })

hi("@punctuation",             { fg = c.fg2 })
hi("@punctuation.bracket",     { fg = c.fg2 })
hi("@punctuation.delimiter",   { fg = c.fg2 })
hi("@punctuation.special",     { fg = c.red })

-- ─── LSP ──────────────────────────────────────────────────────────────────────

hi("LspReferenceText",         { bg = c.bg3 })
hi("LspReferenceRead",         { bg = c.bg3 })
hi("LspReferenceWrite",        { bg = c.bg3, underline = true })
hi("LspSignatureActiveParameter", { fg = c.yellow, bold = true })
hi("LspInlayHint",             { fg = c.fg3, italic = true })
hi("LspCodeLens",              { fg = c.fg3, italic = true })

-- ─── Diagnostics ──────────────────────────────────────────────────────────────

hi("DiagnosticError",          { fg = c.err })
hi("DiagnosticWarn",           { fg = c.warn })
hi("DiagnosticInfo",           { fg = c.info })
hi("DiagnosticHint",           { fg = c.hint })
hi("DiagnosticOk",             { fg = c.green })

hi("DiagnosticUnderlineError", { sp = c.err,  underline = true })
hi("DiagnosticUnderlineWarn",  { sp = c.warn, underline = true })
hi("DiagnosticUnderlineInfo",  { sp = c.info, underline = true })
hi("DiagnosticUnderlineHint",  { sp = c.hint, underline = true })

hi("DiagnosticVirtualTextError", { fg = c.err,  italic = true })
hi("DiagnosticVirtualTextWarn",  { fg = c.warn, italic = true })
hi("DiagnosticVirtualTextInfo",  { fg = c.info, italic = true })
hi("DiagnosticVirtualTextHint",  { fg = c.hint, italic = true })

hi("DiagnosticSignError",      { fg = c.err })
hi("DiagnosticSignWarn",       { fg = c.warn })
hi("DiagnosticSignInfo",       { fg = c.info })
hi("DiagnosticSignHint",       { fg = c.hint })

-- ─── Git ──────────────────────────────────────────────────────────────────────

hi("DiffAdd",                  { fg = c.git_add,    bg = "#1e2d1e" })
hi("DiffChange",               { fg = c.git_change, bg = "#1e2535" })
hi("DiffDelete",               { fg = c.git_del,    bg = "#2d1e1e" })
hi("DiffText",                 { fg = c.fg0,        bg = "#2a3a4a", bold = true })

hi("GitSignsAdd",              { fg = c.git_add })
hi("GitSignsChange",           { fg = c.git_change })
hi("GitSignsDelete",           { fg = c.git_del })

-- ─── Telescope ────────────────────────────────────────────────────────────────

hi("TelescopeBorder",          { fg = c.bg4,  bg = c.bg1 })
hi("TelescopeNormal",          { fg = c.fg1,  bg = c.bg1 })
hi("TelescopePromptBorder",    { fg = c.blue, bg = c.bg1 })
hi("TelescopePromptNormal",    { fg = c.fg0,  bg = c.bg1 })
hi("TelescopePromptPrefix",    { fg = c.cyan })
hi("TelescopeResultsNormal",   { fg = c.fg1,  bg = c.bg1 })
hi("TelescopeSelection",       { fg = c.fg0,  bg = c.bg3, bold = true })
hi("TelescopeSelectionCaret",  { fg = c.cyan, bg = c.bg3 })
hi("TelescopeMatching",        { fg = c.cyan, bold = true })
hi("TelescopePreviewBorder",   { fg = c.bg4,  bg = c.bg1 })
hi("TelescopePreviewNormal",   { fg = c.fg1,  bg = c.bg1 })

-- ─── nvim-cmp ─────────────────────────────────────────────────────────────────

hi("CmpItemAbbr",              { fg = c.fg1 })
hi("CmpItemAbbrDeprecated",    { fg = c.fg3, underline = true })
hi("CmpItemAbbrMatch",         { fg = c.cyan, bold = true })
hi("CmpItemAbbrMatchFuzzy",    { fg = c.cyan })
hi("CmpItemMenu",              { fg = c.fg3, italic = true })

hi("CmpItemKindText",          { fg = c.fg1 })
hi("CmpItemKindMethod",        { fg = c.cyan })
hi("CmpItemKindFunction",      { fg = c.cyan })
hi("CmpItemKindConstructor",   { fg = c.yellow })
hi("CmpItemKindField",         { fg = c.blue })
hi("CmpItemKindVariable",      { fg = c.fg1 })
hi("CmpItemKindClass",         { fg = c.yellow })
hi("CmpItemKindInterface",     { fg = c.yellow })
hi("CmpItemKindModule",        { fg = c.fg0 })
hi("CmpItemKindProperty",      { fg = c.blue })
hi("CmpItemKindUnit",          { fg = c.yellow })
hi("CmpItemKindValue",         { fg = c.orange })
hi("CmpItemKindEnum",          { fg = c.yellow })
hi("CmpItemKindKeyword",       { fg = c.red })
hi("CmpItemKindSnippet",       { fg = c.orange })
hi("CmpItemKindColor",         { fg = c.purple })
hi("CmpItemKindFile",          { fg = c.fg1 })
hi("CmpItemKindReference",     { fg = c.blue })
hi("CmpItemKindFolder",        { fg = c.blue })
hi("CmpItemKindEnumMember",    { fg = c.yellow })
hi("CmpItemKindConstant",      { fg = c.yellow })
hi("CmpItemKindStruct",        { fg = c.yellow })
hi("CmpItemKindEvent",         { fg = c.orange })
hi("CmpItemKindOperator",      { fg = c.fg1 })
hi("CmpItemKindTypeParameter", { fg = c.yellow })

-- ─── nvim-tree ────────────────────────────────────────────────────────────────

hi("NvimTreeNormal",           { fg = c.fg1,  bg = c.bg2 })
hi("NvimTreeNormalNC",         { fg = c.fg2,  bg = c.bg2 })
hi("NvimTreeRootFolder",       { fg = c.cyan, bold = true })
hi("NvimTreeFolderName",       { fg = c.blue })
hi("NvimTreeFolderIcon",       { fg = c.blue })
hi("NvimTreeOpenedFolderName", { fg = c.cyan })
hi("NvimTreeEmptyFolderName",  { fg = c.fg3 })
hi("NvimTreeFileName",         { fg = c.fg1 })
hi("NvimTreeExecFile",         { fg = c.green, bold = true })
hi("NvimTreeGitNew",           { fg = c.git_add })
hi("NvimTreeGitModified",      { fg = c.git_change })
hi("NvimTreeGitDeleted",       { fg = c.git_del })
hi("NvimTreeGitIgnored",       { fg = c.fg3 })
hi("NvimTreeIndentMarker",     { fg = c.bg4 })
hi("NvimTreeWinSeparator",     { fg = c.bg4, bg = c.bg2 })

-- ─── which-key ────────────────────────────────────────────────────────────────

hi("WhichKey",                 { fg = c.cyan })
hi("WhichKeyGroup",            { fg = c.yellow })
hi("WhichKeyDesc",             { fg = c.fg1 })
hi("WhichKeySeparator",        { fg = c.fg3 })
hi("WhichKeyFloat",            { bg = c.bg1 })
hi("WhichKeyBorder",           { fg = c.bg4, bg = c.bg1 })

-- ─── indent-blankline ─────────────────────────────────────────────────────────

hi("IblIndent",                { fg = c.bg4 })
hi("IblScope",                 { fg = c.bg4 })

-- ─── Noice / Notify ───────────────────────────────────────────────────────────

hi("NotifyERRORBorder",        { fg = c.err })
hi("NotifyWARNBorder",         { fg = c.warn })
hi("NotifyINFOBorder",         { fg = c.info })
hi("NotifyHINTBorder",         { fg = c.hint })
hi("NotifyERRORTitle",         { fg = c.err,  bold = true })
hi("NotifyWARNTitle",          { fg = c.warn, bold = true })
hi("NotifyINFOTitle",          { fg = c.info, bold = true })
hi("NotifyHINTTitle",          { fg = c.hint, bold = true })
hi("NotifyERRORBody",          { fg = c.fg1 })
hi("NotifyWARNBody",           { fg = c.fg1 })
hi("NotifyINFOBody",           { fg = c.fg1 })
hi("NotifyHINTBody",           { fg = c.fg1 })

-- ─── mini.statusline / lualine compatible extras ──────────────────────────────

hi("ModeNormal",   { fg = c.bg0, bg = c.cyan,   bold = true })
hi("ModeInsert",   { fg = c.bg0, bg = c.green,  bold = true })
hi("ModeVisual",   { fg = c.bg0, bg = c.purple, bold = true })
hi("ModeReplace",  { fg = c.bg0, bg = c.red,    bold = true })
hi("ModeCommand",  { fg = c.bg0, bg = c.yellow, bold = true })
