local c = {
  -- Visual selection BG, line numbers, and icons/decoration.
  gray_a = "#2b2b2c",
  -- Cursor line and borders.
  gray_b = "#1e1e1f",
  -- Normal BG.
  gray_c = "#111112",
  -- Pmenu and floats.
  gray_d = "#0b0b0c",

  -- Punctuation and normal text (headers in Markdown).
  white_a = "#d2d2d3",
  -- Member variables, types, and keywords (text in Markdown).
  white_b = "#959596",
  -- Comments.
  white_c = "#515053",

  -- Booleans and number literals.
  purple_a = "#b294ff",
  -- Strings and paths.
  purple_b = "#936df3",

  -- Functions.
  blue_a = "#8b9efd",
  -- Comparisions (less than, equal, etc.).
  blue_b = "#7289fd",

  -- Unused.
  pink_a = "#ed5abc",
  -- Unused.
  pink_b = "#d748be",

  -- Warnings.
  yellow_a = "#edb15b",
  -- Namespaces, Lua builtins, and modules.
  yellow_b = "#d79b48",

  -- Git.
  green = "#44ae6e",
  red = "#d16556"
}

vim.cmd "highlight clear"
vim.cmd "syntax reset"

vim.g.colors_name = "degraded"

local hl = vim.api.nvim_set_hl

-- Plugins
hl(0, "DashboardCursor", { fg = c.white_b, bg = c.gray_c })
hl(0, "DashboardDesc", { fg = c.white_b })
hl(0, "DashboardKey", { fg = c.purple_b })
hl(0, "DashboardLogo", { fg = c.white_c })
hl(0, "DashboardFooter", { fg = c.white_c })

hl(0, "BlinkIndent", { fg = c.gray_a })
hl(0, "BlinkIndentCur", { fg = c.gray_a })

hl(0, "Added", { fg = c.green })
hl(0, "Changed", { fg = c.yellow_b })
hl(0, "Removed", { fg = "#d16556" })

hl(0, "GitSignsDeleteVirtLn", { fg = c.red })

-- hl(0, "BlinkCmpKind", { fg = c.gray_c, bg = c.white_a })
-- hl(0, "BlinkCmpMenuSelection", { fg = c.gray_c, bg = c.white_a })
-- hl(0, "BlinkCmpLabelMatch", { bold = true })

-- Native.
hl(0, "StatusLine", { fg = c.white_b, bg = c.gray_c })
hl(0, "StatusLineMode", { fg = c.gray_c, bg = c.white_a })
hl(0, "StatusLinePos", { fg = c.white_b, bg = c.gray_c })
hl(0, "StatusLineSyntax", { fg = c.white_a, bg = c.gray_c })
hl(0, "StatusLineMacro", { fg = c.purple_b, bg = c.gray_c })
hl(0, "StatusLineFile", { fg = c.white_a, bg = c.gray_c })
hl(0, "StatusLineMod", { fg = c.white_a, bg = c.gray_c })
hl(0, "StatusLineError", { fg = c.purple_b, bg = c.gray_c })
hl(0, "StatusLineWarn", { fg = c.yellow_b, bg = c.gray_c })
hl(0, "StatusLineMisc", { fg = c.blue_b, bg = c.gray_c })

hl(0, "StatusLineGitBranch", { fg = c.white_a, bg = c.gray_c, bold = true })
hl(0, "StatusLineGitLines", { fg = c.white_b, bg = c.gray_c })

hl(0, "FoldColumn", { fg = c.gray_a })
hl(0, "FoldColumnClosed", { fg = c.white_a })

hl(0, "DiagnosticError", { fg = c.purple_b })
hl(0, "DiagnosticHint", { fg = c.blue_b })
hl(0, "DiagnosticInfo", { fg = c.blue_b })
hl(0, "DiagnosticOk", { fg = c.white_c })
hl(0, "DiagnosticWarn", { fg = c.yellow_b })

hl(0, "DiagnosticUnderlineError", { sp = c.purple_b, underline = true })
hl(0, "DiagnosticUnderlineHint", { sp = c.blue_b, underline = true })
hl(0, "DiagnosticUnderlineInfo", { sp = c.blue_b, underline = true })
hl(0, "DiagnosticUnderlineOk", { sp = c.white_c, underline = true })
hl(0, "DiagnosticUnderlineWarn", { sp = c.yellow_b, underline = true })

hl(0, "DiagnosticDeprecated", { fg = c.white_c, strikethrough = true })

-- Misc
hl(0, "Normal", { fg = c.white_a, bg = c.gray_c })
hl(0, "EndOfBuffer", { fg = c.gray_c })
hl(0, "NormalNC", { fg = c.white_b, bg = c.gray_d })
hl(0, "Debug", { fg = c.purple_b })
hl(0, "Directory", { fg = c.purple_b })
hl(0, "Error", { fg = c.purple_b })
hl(0, "ErrorMsg", { fg = c.purple_a })
hl(0, "Warning", { fg = c.white_b })
hl(0, "WarningMsg", { fg = c.white_b })
-- TODO: Is this a keyword?
hl(0, "Exception", { fg = c.white_b })
-- TODO: Is this not visible enough?
hl(0, "IncSearch", { fg = c.white_a, bg = c.gray_a, bold = true })
hl(0, "MatchParen", { fg = c.white_a, bg = c.gray_a, bold = true })
-- Used in '%s' commands.
hl(0, "Search", { fg = c.white_a, bg = c.gray_a, bold = true })
hl(0, "Substitute", { fg = c.white_a, bg = c.gray_a, bold = true })
-- TODO: No.
hl(0, "Macro", { fg = c.blue_b })
hl(0, "ModeMsg", { fg = c.white_b })
hl(0, "MoreMsg", { fg = c.white_a })
-- TODO: What?
hl(0, "Question", {})
hl(0, "SpecialKey", { fg = c.purple_b })
hl(0, "Visual", { bg = c.gray_a })
hl(0, "Title", { fg = c.white_a, bold = true })
hl(0, "Conceal", { fg = c.white_c })
hl(0, "NonText", { fg = c.white_c })
hl(0, "Cursor", { fg = c.gray_c, bg = c.white_b })
hl(0, "LineNr", { fg = c.gray_a })
hl(0, "WinSeparator", { fg = c.gray_c })
hl(0, "ColorColumn", { bg = c.gray_d })
hl(0, "SignColumn", { fg = c.gray_a })
hl(0, "CursorLine", {})
hl(0, "CursorLineNr", { fg = c.white_a, bold = true })
hl(0, "Pmenu", { fg = c.white_c, bg = c.gray_d })
hl(0, "PmenuSbar", { bg = c.gray_d })
hl(0, "PmenuThumb", { bg = c.gray_c })
hl(0, "PmenuSel", { fg = c.white_a, bg = c.gray_b, bold = true })

-- Syntax
hl(0, "Boolean", { fg = c.purple_a })
hl(0, "Character", { fg = c.purple_b })
hl(0, "Comment", { fg = c.white_c, italic = true })
hl(0, "Conditional", { fg = c.white_b })
-- TODO: Lua links to this. Change to normal numbers.
hl(0, "Constant", { fg = c.white_a, bold = true })
hl(0, "Delimiter", { fg = c.white_a })
hl(0, "Float", { fg = c.purple_a })
hl(0, "Function", { fg = c.blue_b })
hl(0, "Identifier", { fg = c.white_b })
hl(0, "Keyword", { fg = c.white_b })
-- TODO: What?
-- hl(0, "Label", {})
hl(0, "Number", { fg = c.purple_a })
hl(0, "Operator", { fg = c.white_a })
hl(0, "Comparator", { fg = c.blue_a })
-- TODO: Lua uses this for brackets.
hl(0, "Special", { fg = c.white_a })
hl(0, "SpecialChar", { fg = c.purple_b })
hl(0, "Statement", { fg = c.white_b })
-- TODO: What?
-- hl(0, "StorageClass", {})
hl(0, "String", { fg = c.purple_b })
-- TODO: Where is this used?
hl(0, "Tag", { fg = c.blue_b })
hl(0, "Todo", { fg = c.white_a, bold = true })
hl(0, "Type", { fg = c.white_b })

-- Treesitter
hl(0, "@type.builtin", { link = "Type" })
hl(0, "@operator.comparision", { link = "Comparator" })
hl(0, "@number", { link = "Number" })
hl(0, "@variable.member", { fg = c.white_b })
hl(0, "@function.builtin", { link = "Function" })
hl(0, "@namespace.builtin", { fg = c.yellow_b })

-- Lua and Vimscript
hl(0, "@keyword.vim", { link = "String" })
hl(0, "@function.macro.vim", { link = "String" })
hl(0, "@constant.lua", { fg = c.yellow_b })
hl(0, "@constant.builtin.lua", { fg = c.purple_a })
hl(0, "@module.builtin.lua", { fg = c.yellow_b })
hl(0, "@module.lua", { fg = c.yellow_b })

-- Nix
hl(0, "@constant.builtin.nix", { fg = c.purple_a })

-- C++
hl(0, "@module.cpp", { fg = c.yellow_b })
