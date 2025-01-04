require("smartcolumn").setup({
  colorcolumn        = "100",
  scope              = "window",
  editorconfig       = true,

  disabled_filetypes = {
    "help",
    "text",
    "alpha"
  },

  custom_colorcolumn = {
    markdown = "80",
    nix      = "100"
  }
})
