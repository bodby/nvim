--- @type table<string, string>
local colors = {
  gray1 = "#1d232f",
  gray2 = "#131720",
  gray3 = "#0e1119",

  white1 = "#c2d5ff",
  white2 = "#95a6c6",
  white3 = "#4e596f",

  purple = "#9d7dff",
  blue = "#809cff",
  yellow = "#ffb96b",
  green = "#bbef86",
  red = "#f75fa8",
  cyan = "#89bcff"
}


-- NOTE: Snippets should be highlighted like macros.

--- Atomic highlights that other highlights can inherit.
--- @enum base
local base = {
  -- Syntax.
  identifier = { fg = colors.white1 },
  field = { fg = colors.white2 },
  keyword = {
    fg = colors.cyan,
    bold = true,
    italic = true
  },

  preprocessor = {
    fg = colors.cyan,
    bold = true,
    italic = true
  },

  conditional = { fg = colors.purple, bold = true },
  --- Only works for langauges with a Treesitter parser.
  function_keyword = { fg = colors.purple, bold = true },
  _function = { fg = colors.blue },
  operator = { fg = colors.cyan },
  delimiter = { fg = colors.cyan },
  boolean = { fg = colors.green },
  character = { fg = colors.green },
  --- Nix paths and escape codes.
  special_char = { fg = colors.green, italic = true },
  number = { fg = colors.green },
  _string = { fg = colors.green, italic = true },
  type = { fg = colors.purple },
  --- Type constructors.
  constructor = { fg = colors.yellow },
  tag = { fg = colors.blue },
  module = { fg = colors.yellow, bold = true },
  constant = { fg = colors.yellow, bold = true },
  -- TODO: Find where this is used.
  special = { fg = colors.purple },
  comment = { fg = colors.white3, italic = true },

  -- UI.
  normal = { fg = colors.white2, bg = colors.gray2 },
  popup = { fg = colors.white2, bg = colors.gray3 },
  hover = { fg = colors.white1, bold = true },
  ghost = { fg = colors.white3, italic = true },
  cursor_line = { bg = colors.gray3 },
  line_number = { fg = colors.white3 },
  current_line_number = { fg = colors.cyan, bold = true },
  hml_indicator = { fg = colors.white2, bold = true },
  accent = { fg = colors.cyan, bold = true },
  caret = { fg = colors.cyan },
  cursor = { bg = colors.cyan },
  visual = { bg = colors.gray1 },
  snippet_tabstop = { italic = true },
  --- For blink.cmp and Telescope.
  matching_char = { bold = true },
  matching_search = { fg = colors.red, bold = true },
  matching_punctuation = { fg = colors.yellow, bold = true },
  key = { fg = colors.purple, bold = true },
  directory = { fg = colors.white2 },
  code = { fg = colors.cyan, bg = colors.gray3 },
  separator = { fg = colors.gray1 },
  url = {
    fg = colors.white1,
    underline = true
  },

  title = {
    fg = colors.white1,
    bold = true,
    italic = true
  },

  statusline = { bg = colors.gray3 },
  statusline_directory = { fg = colors.white3, italic = true },
  statusline_file = { fg = colors.white2, italic = true },
  statusline_branch = { fg = colors.white1, bold = true },
  statusline_delta = { fg = colors.white2 },
  --- Line ending types (`CRLF` or `LF`).
  statusline_endings = { fg = colors.white2 },
  statusline_position = { fg = colors.white3 },
  statusline_percent = { fg = colors.white2 },
  statusline_filetype = {
    fg = colors.white1,
    bold = true,
    italic = true
  },

  -- Diagnostics.
  error = { fg = colors.red, bold = true },
  warning = { fg = colors.yellow, bold = true },
  info = { fg = colors.blue, bold = true },
  hint = { fg = colors.purple, bold = true },
  success = { fg = colors.green, bold = true },
  diff_added = { fg = colors.green },
  diff_changed = { fg = colors.yellow },
  diff_removed = { fg = colors.red },
  deprecated = { fg = colors.white3, strikethrough = true },

  -- Todo comments.
  todo = { fg = colors.cyan, bold = true },
  assignee = { fg = colors.blue },
}

--- Override a `base` highlight.
--- @param orig base
--- @param opts table
--- @param nocombine? boolean
--- @return table
--- @nodiscard
local function inherit(orig, opts, nocombine)
  opts = vim.tbl_extend("force", opts, { nocombine = nocombine or false })
  return vim.tbl_deep_extend("force", orig, opts)
end

-- See `:h syntax` for some of these highlights.
--- @type table<string, table>
local highlights = {
  ["Normal"] = base.normal,
  ["StatusLine"] = base.statusline,
  ["NormalFloat"] = base.popup,
  ["Title"] = base.title,
  ["Pmenu"] = inherit(base.popup, { fg = colors.white3 }),
  ["PmenuSel"] = base.hover,
  ["Cursor"] = base.cursor,
  ["CursorLine"] = base.cursor_line,
  ["CursorLineNr"] = base.current_line_number,
  ["CursorLineWrapped"] = base.line_number,
  ["LineNr"] = base.line_number,
  ["LineNrSpecial"] = base.hml_indicator,

  ["Visual"] = base.visual,
  ["Search"] = base.matching_search,
  ["IncSearch"] = { link = "Search" },
  ["Substitute"] = { link = "Search" },
  ["MatchParen"] = base.matching_punctuation,
  ["NonText"] = base.ghost,
  ["Conceal"] = { link = "NonText" },
  ["SnippetTabstop"] = base.snippet_tabstop,

  ["Keyword"] = base.keyword,
  ["PreProc"] = base.preprocessor,
  ["Typedef"] = base.keyword,
  ["StorageClass"] = base.keyword,
  ["Label"] = base.keyword,
  ["Repeat"] = base.keyword,
  ["Exception"] = base.keyword,
  ["Conditional"] = base.conditional,
  ["Identifier"] = base.identifier,
  ["String"] = base._string,
  ["Character"] = base.character,
  ["Special"] = base.special,
  ["SpecialChar"] = base.special_char,
  ["Number"] = base.number,
  ["Float"] = { link = "Number" },
  ["Boolean"] = base.boolean,
  ["Constant"] = base.constant,
  ["Operator"] = base.operator,
  ["Delimiter"] = base.delimiter,
  ["Type"] = base.type,
  ["Function"] = base._function,
  ["Tag"] = { link = "Function" },
  ["Macro"] = { link = "Function" },
  ["Comment"] = base.comment,

  ["Underlined"] = base.url,
  ["Todo"] = base.todo,
  ["Added"] = base.diff_added,
  ["Changed"] = base.diff_changed,
  ["Removed"] = base.diff_removed,
  ["DiffAdd"] = { link = "Added" },
  ["DiffChange"] = { link = "Changed" },
  ["DiffDelete"] = { link = "Removed" },

  -- Diagnostics.
  ["Error"] = base.error,
  ["Warning"] = base.warning,
  ["DiagnosticDeprecated"] = base.deprecated,
  ["DiagnosticError"] = base.error,
  ["DiagnosticInfo"] = base.info,
  ["DiagnosticHint"] = base.hint,
  ["DiagnosticOk"] = base.success,
  ["DiagnosticWarn"] = base.warning,
  ["DiagnosticUnderlineError"] = inherit(base.error, { underline = true }),
  ["DiagnosticUnderlineInfo"] = inherit(base.info, { underline = true }),
  ["DiagnosticUnderlineHint"] = inherit(base.hint, { underline = true }),
  ["DiagnosticUnderlineOk"] = inherit(base.success, { underline = true }),
  ["DiagnosticUnderlineWarn"] = inherit(base.warning, { underline = true }),

  -- Treesitter.
  ["@variable"] = { link = "Identifier" },
  ["@property"] = base.field,
  ["@variable.member"] = { link = "@property" },
  ["@constructor"] = base.constructor,
  ["@keyword.function"] = base.function_keyword,
  ["@keyword.conditional"] = base.conditional,
  ["@function.builtin"] = { link = "@function" },
  ["@module"] = base.module,
  ["@module.builtin"] = { link = "@module" },

  -- Lua.
  ["@constructor.lua"] = base.delimiter,

  -- Todo comments.
  ["@comment.warning"] = { link = "Todo" },
  ["@comment.error"]   = { link = "Todo" },
  ["@comment.todo"]    = { link = "Todo" },
  ["@comment.note"]    = { link = "Todo" },

  -- LSP highlights.
  ["@lsp.type.comment"] = { }
}

--- @type table<string, string>
local stl_highlights = {
  ["Normal"] = colors.cyan,
  ["Visual"] = colors.green,
  ["Select"] = colors.green,
  ["Insert"] = colors.purple,
  ["Replace"] = colors.red,
  ["Command"] = colors.yellow,
  ["Prompt"] = colors.white3,
  ["Shell"] = colors.green,
  ["Limbo"] = colors.white3
}

--- "Alpha" prefixed highlights.
--- @type table<string, table>
local alpha_highlights = {
  ["Buttons"] = base.caret,
  ["HeaderLabel"] = { fg = colors.white2 },
  ["Shortcut"] = base.key,
  ["Header"] = { fg = colors.white3 },
  ["Footer"] = { link = "Comment" }
}

--- "BlinkCmp" prefixed highlights.
--- @type table<string, table>
local blink_highlights = {
  ["Menu"] = { link = "Pmenu" },
  ["MenuSelection"] = { link = "PmenuSel" },
  ["Source"] = { link = "NormalFloat" },
  ["LabelMatch"] = base.matching_char,
  ["Deprecated"] = { link = "DiagnosticDeprecated" },

  -- Types.
  ["KindText"] = { link = "NormalFloat" },
  ["KindMethod"] = { link = "Function" },
  ["KindFunction"] = { link = "Function" },
  ["KindConstructor"] = { link = "@constructor" },
  ["KindField"] = { link = "@variable.member" },
  ["KindVariable"] = { link = "Identifier" },
  ["KindProperty"] = { link = "@property" },
  ["KindClass"] = { link = "Type" },
  ["KindInterface"] = { link = "Type" },
  ["KindStruct"] = { link = "Structure" },
  ["KindModule"] = { link = "@module" },
  ["KindUnit"] = { link = "String" },
  ["KindValue"] = { link = "Number" },
  ["KindEnum"] = { link = "Type" },
  ["KindEnumMember"] = { link = "Constant" },
  ["KindKeyword"] = { link = "Keyword" },
  ["KindConstant"] = { link = "Constant" },
  ["KindSnippet"] = base.key,
  ["KindColor"] = { link = "String" },
  ["KindFile"] = { link = "SpecialChar" },
  ["KindReference"] = { link = "Identifier" },
  ["KindFolder"] = { link = "Directory" },
  ["KindEvent"] = { link = "Type" },
  ["KindOperator"] = { link = "Operator" },
  ["KindTypeParameter"] = { link = "Identifier" }
}

--- "StatusLine" prefixed highlights.
--- @type table<string, table>
local statusline_highlights = {
  ["Directory"] = base.statusline_directory,
  ["File"] = base.statusline_file,
  ["Branch"] = base.statusline_branch,
  ["Delta"] = base.statusline_delta,
  ["Macro"] = base.key,
  ["FileType"] = base.statusline_filetype,
  ["NewLine"] = base.statusline_endings,
  ["Pos"] = base.statusline_position,
  ["Percent"] = base.statusline_percent
}

vim.g.colors_name = "bodby"
vim.cmd("highlight clear")
vim.cmd("syntax reset")

for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end

for k, v in pairs(alpha_highlights) do
  vim.api.nvim_set_hl(0, "Alpha" .. k, v)
end

for k, v in pairs(blink_highlights) do
  vim.api.nvim_set_hl(0, "BlinkCmp" .. k, v)
end

for k, v in pairs(statusline_highlights) do
  local hl = inherit(base.statusline, v)
  vim.api.nvim_set_hl(0, "StatusLine" .. k, hl)
end
