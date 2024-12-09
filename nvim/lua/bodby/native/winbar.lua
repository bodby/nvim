local M = {
  col = {
    file = "%##",
    loc = "%#WinBarLOC#"
  },
  modified_char = "'"
}

function M.setup()
  vim.opt.winbar = "%!v:lua.require('bodby.native.winbar').active()"
end

M.file = function()
  return M.col.file .. "%t "
end

M.loc = function()
  return M.col.loc .. "%L"
end

M.active = function()
  return table.concat({
    " ",
    M.file(),
    "%=",
    M.loc(),
    " "
  })
end

return M
