local M = {}

function M.setup()
  vim.opt.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"
end

M.sign = function()
  return "%s"
end

M.line_nr = function()
  if vim.v.relnum == 0 then
    return "%=" .. vim.v.lnum
  else
    return "%=" .. vim.v.relnum
  end
end

M.active = function()
  return table.concat({
    " ",
    M.sign(),
    M.line_nr(),
    " "
  })
end

-- Used in the dashboard.
M.inactive = function()
  return ""
end

return M
