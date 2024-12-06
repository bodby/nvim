local M = {
  col = {
    file = "%##",
    modified = "%#WinBarMod#",
    loc = "%#WinBarLOC#"
  },
  modified_char = "'"
}

function M.setup()
  -- vim.wo.winbar = "%!v:lua.require('bodby.native.winbar').active()"

  vim.api.nvim_create_autocmd({
    "BufWinEnter",
    "WinEnter"
  }, {
    callback = function(event)
      local windows = vim.fn.win_findbuf(event.buf)

      for _, window in ipairs(windows) do
        M.init(window)
      end
    end
  })
end

function M.init(window)
  vim.wo[window].winbar = "%!v:lua.require('bodby.native.winbar').active(" .. window .. ")"
end

M.file = function(window)
  local modified = ""
  -- if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(window), "modified") then
  --   modified = M.col.modified .. M.modified_char
  -- end
  if vim.bo[vim.api.nvim_win_get_buf(window)].modified == true then
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

M.active = function(window)
  local buf = vim.api.nvim_win_get_buf(window)

  if vim.bo[buf].filetype == "alpha"
  or vim.bo[buf].filetype == "TelescopePrompt"
  or vim.bo[buf].filetype == "BlinkCmp" then
    return ""
  end

  return table.concat({
    " ",
    M.file(window),
    "%=",
    M.loc(),
    " "
  })
end

return M
