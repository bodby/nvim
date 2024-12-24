require("blink.indent").setup({
  enabled = true,
  blocked = {
    filetypes = { "alpha" }
  },

  static = {
    enabled    = false,
    char       = "│",
    priority   = 1,
    highlights = { "BlinkIndent" }
  },
  scope = {
    enabled    = true,
    char       = "│",
    priority   = 1024,
    highlights = { "BlinkIndentCur" }
  }
})
