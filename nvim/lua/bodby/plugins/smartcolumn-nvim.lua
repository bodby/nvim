require("smartcolumn").setup({
  colorcolumn  = "100",
  scope        = "window",
  editorconfig = true,

  disabled_filetypes = {
    "help",
    "text",
    "alpha"
  },

  custom_colorcolumn = {
    markdown = "80",
    nix      = "100",
    latex    = "100",
    tex      = "100"
  }
})

require("virt-column").setup({
  enabled = true,
  char    = "│",
  -- virtcolumn = "80",
  highlight = "VirtColumn",
  exclude   = { }
})
