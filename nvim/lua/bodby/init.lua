require "bodby.config.options"
require "bodby.config.autocmds"

vim.cmd.colorscheme "degraded"

vim.schedule(function()
  require "bodby.config.mappings"
end)

vim.api.nvim_create_augroup("status", {})

require("bodby.native.statusline").setup()
require("bodby.native.statuscolumn").setup()
-- require("bodby.native.winbar").setup()
-- require "bodby.plugins"
