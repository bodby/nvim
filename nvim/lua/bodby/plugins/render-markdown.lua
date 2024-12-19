local plugin = require "render-markdown"

plugin.setup({
  preset = "obsidian",
  injections = {
    gitcommit = {
      enabled = true,
      query = [[
        ((message) @injection.content
          (#set! injection.combined)
          (#set! injection.include-children)
          (#set! injection.language "markdown"))
      ]]
    }
  },

  render_modes = { "n", "c", "t" },
  anti_conceal = { enabled = false },

  latex = { enabled = false },
})

local map = vim.keymap.set

map("n", "<Leader>m", plugin.toggle)
