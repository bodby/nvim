-- Load options.
require "bodby.options"

-- Colorscheme.
vim.cmd.colorscheme "bobi"

vim.schedule(function()
  require "bodby.mappings"
end)
