local M = {
  col = {
    file = "%##",
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
    modified = M.col.modified .. M.modified_char
  end

  -- if vim.fn.expand "%t" == "" or vim.fn.expand "%t" == "[No Name]" then
  --   return "New file" .. modified .. " "
  -- else
  return M.col.file .. "%t" .. modified .. " "
  -- end
end

M.loc = function()
  return M.col.loc .. "%L"
end

M.active = function()
  if vim.bo.filetype == "alpha" or vim.bo.filetype == "TelescopePrompt" then
    return ""
  end

  return table.concat({
    " ",
    M.file(),
    "%=",
    M.loc(),
    " "
  })
end

return M
