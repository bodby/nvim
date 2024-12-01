local o = vim.opt

require("bodby.native.statusline").setup({
  use_icons = false,
  mode_padding = true,
  pos_padding = false,
  always_show_diagnostics = false
})

require("bodby.native.statuscolumn").setup()
-- require "bodby.nvim.winbar"
