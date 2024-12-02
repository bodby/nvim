local M = {}

function M.setup()
  vim.opt.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').column()"
end
