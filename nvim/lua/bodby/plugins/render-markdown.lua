local plugin = require "render-markdown"

plugin.setup({
  preset     = "obsidian",
  injections = {
    gitcommit = {
      enabled = true,
      query   = [[
        ((message) @injection.content
          (#set! injection.combined)
          (#set! injection.include-children)
          (#set! injection.language "markdown"))
      ]]
    }
  },

  render_modes     = true,
  anti_conceal     = { enabled = true },
  latex            = { enabled = false },
  paragraph        = { enable = false },
  bullet           = { enabled = false },
  inline_highlight = { enabled = false },
  html             = { enabled = false },

  heading = {
    enabled     = true,
    sign        = true,
    position    = "inline",
    icons       = { "" },
    signs       = { "1", "2", "3", "4", "5", "6" },
    width       = "block",
    backgrounds = { "Title" },
    foregrounds = { "Title" },
  },

  code = {
    enabled   = true,
    sign      = false,
    style     = "normal",
    width     = "block",
    left_pad  = 2,
    right_pad = 2,
    border    = "thick"
  },

  dash = {
    enabled = true,
    icon    = "─",
    width   = "full"
  },

  checkbox = {
    enabled   = true,
    unchecked = { icon = "( )" },
    checked   = { icon = "(X)" },
    custom    = { }
  },

  quote = {
    enabled = true,
    icon    = "│"
  },

  callout = {
    note = {
      rendered  = "NOTE:",
      highlight = "Todo"
    }
  },

  pipe_table = {
    enabled             = true,
    preset              = "none",
    alignment_indicator = "┅",
    head                = "WinSeparator",
    row                 = "WinSeparator",
    filler              = "RenderMarkdownTableFill"
  },

  link = {
    enabled   = true,
    footnote  = { superscript = true },
    image     = "",
    email     = "",
    hyperlink = "",
    wiki      = { icon = "" },
    custom    = { }
  }
})

vim.keymap.set("n", "<Leader>m", plugin.toggle)
