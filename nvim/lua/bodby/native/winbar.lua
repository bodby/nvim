local M = {
  col = {
    loc = "%#WinBarLOC#",
    modified = "%#WinBarMod#"
  },
  modified_char = "'",
}

local blocked_filetypes = {
  "TelescopePrompt",
  "blink-cmp-menu",
  "blink-cmp-documentation",
  "blink-cmp-signature"
}

function M.setup()
  vim.wo.winbar = "%!v:lua.require('bodby.native.winbar').active(0)"

  vim.api.nvim_create_autocmd({
    "WinEnter",
    "BufEnter"
  }, {
    group = "status",
    callback = function(event)
      vim.schedule(function()
        local windows = vim.fn.win_findbuf(event.buf);
        for _, window in pairs(windows) do
          for _, ft in pairs(blocked_filetypes) do
            if vim.bo[vim.api.nvim_win_get_buf(window)].filetype == ft then
              return
            end
          end

          vim.wo[window].winbar = "%!v:lua.require('bodby.native.winbar').active(" .. window .. ")"
        end
      end)
    end
  })
end

M.file = function(window)
  local mod_suffix = ""
  local filename = ""
  if vim.api.nvim_win_is_valid(window) then
    local buffer = vim.api.nvim_win_get_buf(window)

    if vim.api.nvim_buf_get_name(buffer) ~= "" then
      filename = "%t"
    else
      filename = "New file"
    end

    if vim.bo[buffer].modified then
      mod_suffix = M.col.modified .. M.modified_char
    end
  end

  return filename .. mod_suffix
end

M.loc = function()
  return M.col.loc .. "%L"
end

M.active = function(window)
  if vim.api.nvim_win_is_valid(window) then
    if vim.bo[vim.api.nvim_win_get_buf(window)].filetype == "alpha" then
      return ""
    end
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
