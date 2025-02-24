require("smartcolumn").setup({
  colorcolumn  = "99",
  scope        = "window",
  editorconfig = true,

  disabled_filetypes = {
    "help",
    "text",
    "alpha"
  },

  custom_colorcolumn = {
    markdown = "79",
    nix      = "99",
    latex    = "79",
    tex      = "79"
  }
})

require("virt-column").setup({
  enabled = true,
  char    = "│",
  -- virtcolumn = "80",
  highlight = "VirtColumn",
  exclude   = { }
})
