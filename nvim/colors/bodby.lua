--- @class (exact) Highlights
--- @field prefix? string
--- @field base? Base
--- @field highlights table<string, table>

--- @type table<string, string>
local colors = {
  -- TODO: White saturations.
  white1 = '#aec5f2',
  white2 = '#91a4ca',
  white3 = '#495674',
  gray1 = '#12151c',
  gray2 = '#050505',
  red = '#ff85c2',
  green = '#a9f4a0',
  -- #ffccc9
  yellow = '#ffd0c7',
  blue = '#809cff',
  purple = '#9f8fff',
  cyan = '#8cbcff',
}

--- Atomic highlights that others can inherit from.
--- @enum Base
local base = {
  -- Syntax.
  identifier = { fg = colors.white1 },
  parameter = { fg = colors.white1, italic = true },
  field = { fg = colors.white2 },
  property = { fg = colors.white2 },
  keyword = { fg = colors.cyan, italic = true },
  preprocessor = { fg = colors.cyan, italic = true },
  conditional = { fg = colors.purple, italic = true },
  function_keyword = { fg = colors.purple },
  _function = { fg = colors.blue },
  operator = { fg = colors.cyan },
  operator_keyword = { fg = colors.cyan, italic = true },
  delimiter = { fg = colors.cyan },
  boolean = { fg = colors.purple, italic = true },
  character = { fg = colors.green },
  --- Nix paths and escape codes.
  special_char = { fg = colors.cyan, italic = true },
  number = { fg = colors.yellow },
  _string = { fg = colors.green, italic = true },
  type = { fg = colors.purple },
  constructor = { fg = colors.yellow },
  tag = { fg = colors.yellow },
  label = { fg = colors.yellow },
  module = { fg = colors.yellow, italic = true },
  constant = { fg = colors.white1, bold = true },
  builtin = { fg = colors.yellow, italic = true },
  special = { fg = colors.cyan, italic = true },
  comment = { fg = colors.white3, italic = true },
  -- UI.
  normal = { fg = colors.white2, bg = colors.gray2 },
  popup = { fg = colors.white2 },
  border = { fg = colors.gray1 },
  hover = { fg = colors.white1, bold = true },
  ghost = { fg = colors.white3, italic = true },
  folded = { fg = colors.white3 },
  folded_range = { fg = colors.white3 },
  cursor_line = {},
  line_number = { fg = colors.white3 },
  current_line_number = { fg = colors.cyan, bold = true },
  accent = { fg = colors.cyan, bold = true },
  caret = { fg = colors.cyan },
  cursor = { bg = colors.cyan },
  visual = { bg = colors.gray1 },
  snippet_tabstop = { italic = true },
  --- For Blink Completion and Telescope.
  matching_char = { underline = true },
  matching_search = { underline = true },
  matching_punctuation = { fg = colors.cyan, underline = true },
  key = { fg = colors.cyan },
  directory = { fg = colors.white2 },
  code = { fg = colors.cyan },
  separator = { fg = colors.gray1 },
  url = { fg = colors.purple },
  spell_bad = { sp = colors.red, undercurl = true },
  spell_rare = { sp = colors.purple, undercurl = true },
  spell_casing = { sp = colors.blue, undercurl = true },
  title_number = { fg = colors.white3 },
  title = {
    fg = colors.white1,
    bold = true,
    italic = true,
  },
  statusline = {},
  statusline_cwd = { fg = colors.purple, italic = true },
  statusline_prefix = {
    fg = colors.white1,
    bold = true,
    italic = true,
  },
  statusline_path = { fg = colors.white2 },
  statusline_branch = { fg = colors.purple },
  statusline_diff = { fg = colors.white3 },
  statusline_lines = { fg = colors.white3 },
  statusline_filetype = { fg = colors.white2, italic = true },
  tabline = {},
  tab_inactive = { fg = colors.white3 },
  tab = {
    fg = colors.cyan,
    bg = colors.gray1,
    bold = true,
    underline = true,
  },
  buffer_inactive = { fg = colors.white3 },
  buffer = {
    fg = colors.white1,
    sp = colors.cyan,
    bold = true,
    italic = true,
    underline = true,
  },
  -- Diagnostics.
  error = { fg = colors.red },
  warn = { fg = colors.yellow },
  info = { fg = colors.blue },
  hint = { fg = colors.purple },
  success = { fg = colors.green },
  diff_added = { fg = colors.green },
  diff_changed = { fg = colors.yellow },
  diff_removed = { fg = colors.red },
  deprecated = { fg = colors.white3, strikethrough = true },
  unnecessary = { sp = colors.white3, underline = true },
  -- Todo comments.
  todo = { fg = colors.cyan },
  assignee = { fg = colors.blue },
}

--- Override a `base` highlight, returning a table usable in highlights.
--- @generic T
--- @param orig Base
--- @param opts table<string, T>
--- @return table<string, T>
local function inherit(orig, opts)
  return vim.tbl_deep_extend('force', orig, opts)
end

--- Shorter highlight function.
--- @param name string
--- @param opts table<string, any>
local function hl(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

--- Normal/uncategorized highlights.
--- @type Highlights
local highlights = {
  highlights = {
    ['Normal'] = base.normal,
    ['StatusLine'] = base.statusline,
    ['TabLine'] = base.tabline,
    ['NormalFloat'] = base.popup,
    ['FloatBorder'] = base.border,
    ['Folded'] = base.folded,
    ['MsgArea'] = base.popup,
    ['Title'] = base.title,
    ['Pmenu'] = inherit(base.popup, { fg = colors.white3 }),
    ['PmenuSel'] = base.hover,
    ['Cursor'] = base.cursor,
    ['CursorLine'] = base.cursor_line,
    ['CursorLineNr'] = base.current_line_number,
    ['LineNr'] = base.line_number,
    ['CursorLineNrWrapped'] = base.current_line_number,
    ['LineNrWrapped'] = base.separator,
    ['LineNrVirt'] = base.separator,
    ['WinSeparator'] = base.separator,
    ['MsgSeparator'] = base.separator,
    ['Visual'] = base.visual,
    ['Search'] = base.matching_search,
    ['IncSearch'] = { link = 'Search' },
    ['CurSearch'] = { link = 'Search' },
    ['Substitute'] = { link = 'Search' },
    ['MatchParen'] = base.matching_punctuation,
    ['NonText'] = base.ghost,
    ['Conceal'] = { link = 'NonText' },
    ['SnippetTabstop'] = base.snippet_tabstop,
    ['Keyword'] = base.keyword,
    ['PreProc'] = base.preprocessor,
    ['Typedef'] = base.keyword,
    ['StorageClass'] = base.keyword,
    ['Label'] = base.label,
    ['Repeat'] = base.keyword,
    ['Exception'] = base.keyword,
    ['Conditional'] = base.conditional,
    ['Identifier'] = base.identifier,
    ['Statement'] = {},
    ['String'] = base._string,
    ['Character'] = base.character,
    ['Special'] = base.special,
    ['SpecialKey'] = base.special,
    ['QuickFixLine'] = base.accent,
    ['SpecialChar'] = base.special_char,
    ['Number'] = base.number,
    ['Float'] = { link = 'Number' },
    ['Boolean'] = base.boolean,
    ['Constant'] = base.constant,
    ['Operator'] = base.operator,
    ['Delimiter'] = base.delimiter,
    ['Type'] = base.type,
    ['Function'] = base._function,
    ['Tag'] = base.tag,
    ['Macro'] = { link = 'Function' },
    ['Comment'] = base.comment,
    ['Underlined'] = base.url,
    ['Directory'] = base.directory,
    ['Todo'] = base.todo,
    ['Added'] = base.diff_added,
    ['Changed'] = base.diff_changed,
    ['Removed'] = base.diff_removed,
    ['DiffAdd'] = { link = 'Added' },
    ['DiffChange'] = { link = 'Changed' },
    ['DiffDelete'] = { link = 'Removed' },
    -- Diagnostics.
    ['Error'] = base.error,
    ['Warning'] = base.warn,
    ['ErrorMsg'] = { link = 'Error' },
    ['WarningMsg'] = { link = 'Warning' },
    ['MoreMsg'] = { link = 'Question' },
    ['Question'] = base.popup,
    ['DiagnosticUnnecessary'] = base.unnecessary,
    ['DiagnosticDeprecated'] = base.deprecated,
    ['DiagnosticError'] = base.error,
    ['DiagnosticInfo'] = base.info,
    ['DiagnosticHint'] = base.hint,
    ['DiagnosticOk'] = base.success,
    ['DiagnosticWarn'] = base.warn,
    ['DiagnosticUnderlineError'] = { sp = base.error.fg, underline = true },
    ['DiagnosticUnderlineInfo'] = { sp = base.info.fg, underline = true },
    ['DiagnosticUnderlineHint'] = { sp = base.hint.fg, underline = true },
    ['DiagnosticUnderlineOk'] = { sp = base.success.fg, underline = true },
    ['DiagnosticUnderlineWarn'] = { sp = base.warn.fg, underline = true },
    ['SpellBad'] = base.spell_bad,
    ['SpellRare'] = base.spell_rare,
    ['SpellCap'] = base.spell_casing,
  },
}

--- @type Highlights
local treesitter_highlights = {
  prefix = '@',
  highlights = {
    ['variable'] = { link = 'Identifier' },
    ['variable.parameter'] = base.parameter,
    ['property'] = base.property,
    ['variable.member'] = base.field,
    ['constructor'] = base.constructor,
    ['keyword.function'] = base.function_keyword,
    ['keyword.conditional'] = { link = 'Conditional' },
    ['keyword.operator'] = base.operator_keyword,
    ['punctuation.special'] = { link = 'Delimiter' },
    ['tag.delimiter'] = { link = 'Delimiter' },
    ['character.special'] = { link = 'Operator' },
    ['constant.builtin'] = base.builtin,
    ['variable.builtin'] = { link = 'Constant' },
    ['function.builtin'] = { link = '@function' },
    ['type.builtin'] = { link = 'Type' },
    ['module'] = base.module,
    ['module.builtin'] = { link = '@module' },
    ['namespace'] = { link = '@module' },
    ['constructor.lua'] = { link = 'Delimiter' },
    ['variable.builtin.luadoc'] = { link = '@variable.parameter.builtin' },
    ['constructor.ocaml'] = { link = 'Delimiter' },
    ['attribute.rust'] = { link = 'Label' },
    ['tag.attribute.html'] = { link = '@property' },
    ['punctuation.special.bash'] = inherit(
      base.delimiter,
      { nocombine = true }
    ),
    ['markup.raw'] = base.code,
    ['markup.raw.block'] = inherit(base.delimiter, { nocombine = true }),
    ['markup.quote.markdown'] = {},
    ['markup.list'] = inherit(base.comment, { italic = false }),
    ['markup.link'] = base.url,
    ['markup.strong'] = { fg = colors.white1, bold = true },
    -- ['module.latex'] = { link = 'Keyword' },
    -- ['punctuation.bracket.latex'] = inherit(
    --   base.delimiter,
    --   { nocombine = true }
    -- ),
    ['string.special.symbol.bibtex'] = { link = 'Identifier' },
    ['string.special.path'] = { link = 'String' },
    ['variable.parameter.builtin'] = { link = 'Delimiter' },
    ['keyword.import.nix'] = { link = 'Function' },
    -- Todo comments.
    ['comment.warning'] = { link = 'Todo' },
    ['comment.error'] = { link = 'Todo' },
    ['comment.todo'] = { link = 'Todo' },
    ['comment.note'] = { link = 'Todo' },
    ['constant.comment'] = base.assignee,
    ['constant.typst'] = { link = 'Identifier' },
    ['markup.link.label.typst'] = { link = 'Tag' },
  },
}

--- @type Highlights
local lsp_highlights = {
  prefix = '@lsp.',
  highlights = {
    -- TODO: Unresolved 50% opacity link colors for Markdown.
    ['type.comment'] = {},
    ['type.macro'] = {},
    ['mod.global'] = { link = '@module' },
    ['type.keyword'] = {},
    ['type.decorator.lua'] = { link = '@keyword.lua' },
    ['type.macro.lua'] = {},
    ['type.type.lua'] = {},
  },
}

--- @type Highlights
local alpha_highlights = {
  prefix = 'Alpha',
  highlights = {
    ['Buttons'] = base.caret,
    ['HeaderLabel'] = { fg = colors.white2 },
    ['Shortcut'] = base.key,
    ['Header'] = { fg = colors.white3 },
    ['Footer'] = { link = 'Comment' },
  },
}

--- @type Highlights
local blink_highlights = {
  prefix = 'BlinkCmp',
  highlights = {
    ['Menu'] = { link = 'Pmenu' },
    ['MenuBorder'] = { link = 'FloatBorder' },
    ['MenuSelection'] = { link = 'PmenuSel' },
    ['Source'] = { link = 'NormalFloat' },
    ['LabelMatch'] = base.matching_char,
    ['Deprecated'] = { link = 'DiagnosticDeprecated' },
    -- Types.
    ['KindText'] = { link = 'NormalFloat' },
    ['KindMethod'] = { link = 'Function' },
    ['KindFunction'] = { link = 'Function' },
    ['KindConstructor'] = { link = '@constructor' },
    ['KindField'] = { link = '@variable.member' },
    ['KindVariable'] = { link = 'Identifier' },
    ['KindProperty'] = { link = '@property' },
    ['KindClass'] = { link = 'Type' },
    ['KindInterface'] = { link = 'Type' },
    ['KindStruct'] = { link = 'Structure' },
    ['KindModule'] = { link = '@module' },
    ['KindUnit'] = { link = 'String' },
    ['KindValue'] = { link = 'Number' },
    ['KindEnum'] = { link = 'Type' },
    ['KindEnumMember'] = { link = 'Constant' },
    ['KindKeyword'] = { link = 'Keyword' },
    ['KindConstant'] = { link = 'Constant' },
    ['KindSnippet'] = base.key,
    ['KindColor'] = { link = 'String' },
    ['KindFile'] = { link = 'SpecialChar' },
    ['KindReference'] = { link = 'Identifier' },
    ['KindFolder'] = { link = 'Directory' },
    ['KindEvent'] = { link = 'Type' },
    ['KindOperator'] = { link = 'Operator' },
    ['KindTypeParameter'] = { link = 'Identifier' },
  },
}

--- @type Highlights
local telescope_highlights = {
  prefix = 'Telescope',
  highlights = {
    ['PromptNormal'] = { link = 'NormalFloat' },
    ['PromptBorder'] = { link = 'FloatBorder' },
    ['ResultsNormal'] = { link = 'Pmenu' },
    ['ResultsBorder'] = { link = 'FloatBorder' },
    ['PreviewNormal'] = { link = 'NormalFloat' },
    ['PreviewBorder'] = { link = 'FloatBorder' },
    ['Matching'] = base.matching_char,
    ['Selection'] = { link = 'PmenuSel' },
    ['SelectionCaret'] = base.caret,
    ['MultiSelection'] = { fg = colors.cyan },
    ['MultiIcon'] = base.accent,
    -- Symbols.
    ['ResultsMethod'] = { link = 'Function' },
    ['ResultsFunction'] = { link = 'Function' },
    ['ResultsField'] = { link = '@variable.member' },
    ['ResultsVariable'] = { link = 'Identifier' },
    ['ResultsIdentifier'] = { link = 'Identifier' },
    ['ResultsClass'] = { link = 'Type' },
    ['ResultsStruct'] = { link = 'Structure' },
    ['ResultsNumber'] = { link = 'Number' },
    ['ResultsConstant'] = { link = 'Constant' },
    ['ResultsComment'] = { link = 'Comment' },
    ['ResultsOperator'] = { link = 'Operator' },
  },
}

--- @type Highlights
local render_md_highlights = {
  prefix = 'RenderMarkdown',
  highlights = {
    ['Header'] = base.title_number,
    ['Code'] = { bg = base.code.bg },
    ['CodeInline'] = base.code,
    ['Dash'] = { link = 'WinSeparator' },
    ['TableHead'] = { link = 'WinSeparator' },
    ['TableRow'] = { link = 'WinSeparator' },
  },
}

--- @type Highlights
local statusline_highlights = {
  prefix = 'StatusLine',
  highlights = {
    ['Prefix'] = base.statusline_prefix,
    ['CWD'] = base.statusline_cwd,
    ['Path'] = base.statusline_path,
    ['Branch'] = base.statusline_branch,
    ['Diff'] = base.statusline_diff,
    ['Macro'] = base.key,
    ['FileType'] = base.statusline_filetype,
    ['Lines'] = base.statusline_lines,
    ['Error'] = inherit(base.error, { bg = base.statusline.bg }),
    ['Warn'] = inherit(base.warn, { bg = base.statusline.bg }),
    ['Info'] = inherit(base.info, { bg = base.statusline.bg }),
    ['Hint'] = inherit(base.hint, { bg = base.statusline.bg }),
    ['Normal'] = { fg = colors.white3, bold = true },
    ['Visual'] = { fg = colors.green, bold = true },
    ['Select'] = { fg = colors.green, bold = true },
    ['Insert'] = { fg = colors.cyan, bold = true },
    ['Replace'] = { fg = colors.red, bold = true },
    ['Command'] = { fg = colors.purple, bold = true },
    ['Prompt'] = { fg = colors.white3, bold = true },
    ['Shell'] = { fg = colors.green, bold = true },
    ['Limbo'] = { fg = colors.white3, bold = true },
  },
}

--- @type Highlights
local tabline_highlights = {
  prefix = 'TabLine',
  base = base.tabline,
  highlights = {
    ['Tab'] = base.tab,
    ['TabNC'] = base.tab_inactive,
    ['Buffer'] = base.buffer,
    ['BufferNC'] = base.buffer_inactive,
  },
}

--- @type Highlights
local gaslighting_highlights = {
  prefix = 'Gaslighting',
  highlights = {
    ['GaslightingUnderline'] = { fg = colors.gray1 },
  },
}

--- @type Highlights
local fold_highlights = {
  prefix = 'Folded',
  highlights = {
    ['Ellipsis'] = base.folded_range,
    ['Range'] = base.folded_range,
  },
}

local indentscope_highlights = {
  prefix = 'MiniIndentscope',
  highlights = {
    ['Symbol'] = { fg = colors.cyan },
  },
}

vim.g.colors_name = 'bodby'
vim.cmd.highlight('clear')
vim.cmd.syntax('reset')

--- List of all the highlight groups to apply.
--- You can comment out the ones you don't need.
--- @type table<string, Highlights>[]
local all = {
  highlights,
  treesitter_highlights,
  lsp_highlights,
  -- alpha_highlights,
  blink_highlights,
  telescope_highlights,
  -- render_md_highlights,
  statusline_highlights,
  tabline_highlights,
  -- indentscope_highlights,
  -- fold_highlights,
  -- gaslighting_highlights,
}

for _, v in ipairs(all) do
  local prefix = v.prefix or ''
  local b = v.base or {}
  for k, opts in pairs(v.highlights) do
    hl(prefix .. k, inherit(b, opts))
  end
end

vim.g.terminal_color_0 = colors.gray1
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_5 = colors.purple
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.white2
vim.g.terminal_color_8 = colors.white3
vim.g.terminal_color_9 = colors.red
vim.g.terminal_color_10 = colors.green
vim.g.terminal_color_11 = colors.yellow
vim.g.terminal_color_12 = colors.blue
vim.g.terminal_color_13 = colors.purple
vim.g.terminal_color_14 = colors.cyan
vim.g.terminal_color_15 = colors.white1
