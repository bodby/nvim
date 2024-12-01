require "bodby.config.options"
require "bodby.config.autocmds"

vim.cmd.colorscheme "degraded"

vim.schedule(function()
  require "bodby.config.mappings"
end)

require "bodby.native"
-- require "bodby.plugins"
