local M = {}

local colors = {
  loc = "%#WinBarLOC#",
  modified = "%#WinBarMod#"
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
          -- Does Lua not have matching/mapping? Surely there must be a better way to do this.
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

file = function(window)
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
      mod_suffix = colors.modified .. "'"
    end
  end

  return filename .. mod_suffix
end

loc = function()
  return colors.loc .. "%L"
end

M.active = function(window)
  if vim.api.nvim_win_is_valid(window) then
    if vim.bo[vim.api.nvim_win_get_buf(window)].filetype == "alpha" then
      return " AAAAAAAAAAA"
    end
  end

  return table.concat({
    " ",
    file(window),
    "%=",
    loc(),
    " "
  })
end

return M
