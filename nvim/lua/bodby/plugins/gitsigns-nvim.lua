local map = vim.keymap.set

require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "v" },
    topdelete = { text = "^" },
    changedelete = { text = "│" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "v" },
    topdelete = { text = "^" },
    changedelete = { text = "│" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = false,
  signcolumn = false,
  numhl = false,
  linehl = false,
  word_diff = false,
  auto_attach = true,
  update_debounce = 500
})

map("n", "<Leader>g", function()
  require("gitsigns").toggle_deleted()
  require("gitsigns").toggle_signs()
  -- Fixes the deleted line sometimes not disappearing.
  vim.cmd "redraw!"
end)
