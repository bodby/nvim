local M = {
  col = {
    file = "%#WinBarFile#",
    modified = "%#WinBarMod#",
    loc = "%#WinBarLOC#"
  },
  modified_char = "'"
}

function M.setup()
  vim.opt.winbar = "%!v:lua.require('bodby.native.winbar').active()"
end

M.file = function()
  local modified = ""
  if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
    modified = M.modified_char
  end

  -- if vim.fn.expand "%t" == "" or vim.fn.expand "%t" == "[No Name]" then
  --   return "New file" .. modified .. " "
  -- else
  return "%t" .. modified .. " "
  -- end
end

M.loc = function()
  return "%L"
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
