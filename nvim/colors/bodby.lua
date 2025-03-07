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
  variable = { fg = colors.white1 },
  field = { fg = colors.white2 },
  keyword = {
    fg = colors.cyan,
    bold = true,
    italic = true
  },

  conditional_keyword = { fg = colors.purple, bold = true },
  function_keyword = { fg = colors.purple, bold = true },
  _function = { fg = colors.blue },
  operator = { fg = colors.cyan },
  delimiter = { fg = colors.cyan },
  boolean = { fg = colors.green },
  character = { fg = colors.green },
  number = { fg = colors.green },
  _string = { fg = colors.green, italic = true },
  type = { fg = colors.purple },
  class = { fg = colors.purple },
  enum = { fg = colors.purple },
  enum_member = { fg = colors.yellow },
  --- Typeclasses and traits.
  interface = { fg = colors.purple },
  --- Type constructors.
  constructor = { fg = colors.yellow },
  tag = { fg = colors.blue },
  module = { fg = colors.yellow },
  constant = { fg = colors.yellow, bold = true },

  -- UI.
  normal = { fg = colors.white2, bg = colors.gray2 },
  popup = { fg = colors.white2, bg = colors.gray3 },
  accent = { fg = colors.cyan, bold = true },
  caret = { fg = colors.cyan },
  key = { fg = colors.purple, bold = true },
  directory = { fg = colors.white2 },
  code = { fg = colors.cyan, bg = colors.gray3 },
  separator = { fg = colors.gray1 },
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

  -- Diagnostics.
  error = { fg = colors.red, bold = true },
  warning = { fg = colors.yellow, bold = true },
  info = { fg = colors.blue, bold = true },
  hint = { fg = colors.purple, bold = true },
  deprecated = {
    fg = colors.white3,
    sp = colors.white3,
    strikethrough = true
  },

  -- Todo comments.
  todo = { fg = colors.cyan, bold = true },
  assignee = { fg = colors.blue },
}

-- TODO: Allow inheriting from 'base' using `vim.tbl_deep_extend()`.
local function inherit()

end

--- @type table<string, table>
local highlights = {
  -- Syntax.
  ["Keyword"] = {
    fg = colors.cyan,
    bold = true,
    italic = true
  },

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
  ["Buttons"] = { fg = colors.cyan },
  ["HeaderLabel"] = { fg = colors.white2 },
  ["Shortcut"] = { fg = colors.purple, bold = true },
  ["Header"] = { fg = colors.white3 },
  ["Footer"] = { fg = colors.white3, italic = true },
}

--- "BlinkCmp" prefixed highlights.
--- @type table<string, table>
local blink_highlights = {
  
}

vim.g.colors_name = "bodby"
vim.cmd("highlight clear")
vim.cmd("syntax reset")
