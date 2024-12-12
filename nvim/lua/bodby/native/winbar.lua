local M = {
  col = {
    loc = "%#WinBarLOC#"
  },
  modified_char = "'"
}

function M.setup()
  vim.opt.winbar = "%!v:lua.require('bodby.native.winbar').active()"
end

M.file = function()
  return "%t"
end

M.loc = function()
  return M.col.loc .. "%L"
end

M.active = function()
  return table.concat({
    " %t",
    "%=",
    M.loc(),
    " "
  })
end

return M
