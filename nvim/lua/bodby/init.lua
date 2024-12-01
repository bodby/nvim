require "bodby.options"
require "bodby.autocmds"

vim.cmd.colorscheme "degraded"

vim.schedule(function()
  require "bodby.mappings"
end)

require "bodby.native"
require "bodby.plugins"
