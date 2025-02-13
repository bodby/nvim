local M = { }

local colors = {
  default        = "%#TabLine#",
  active         = "%#TabLineSel#",
  inactive       = "%#TabLineInactive#",
  index          = "%#TabLineIndex#",
  index_inactive = "%#TabLineIndexNC#"
}

function M.setup()
  vim.opt.tabline = "%!v:lua.require('bodby.native.tabline').active()"

  vim.api.nvim_create_autocmd({
    "TabNew",
    "TabClosed"
  }, {
    group    = "status",
    callback = function(event)
      vim.schedule(function()
        vim.opt.tabline = "%!v:lua.require('bodby.native.tabline').active()"
      end)
    end
  })
end

-- The Most Efficient Padding Algorithm You Will Ever See.
local function pad(str, max)
  if str:len() >= max then return str end

  local padding = ""
  for x = 1, max - str:len(), 1 do
    padding = padding .. " "
  end

  return str .. padding
end

local function get_diagnostic_hl(windows)
  for _, win in ipairs(windows) do
    if vim.api.nvim_win_is_valid(win) then
      local diagnostics = vim.diagnostic.count(vim.api.nvim_win_get_buf(win))

      if diagnostics ~= 0 then
        -- TODO: Find a shorter way to write this.
        if diagnostics[1] ~= nil and diagnostics[1] > 0 then
          return "%#TabLineError#"
        elseif diagnostics[2] ~= nil and diagnostics[2] > 0 then
          return "%#TabLineWarn#"
        elseif diagnostics[3] ~= nil and diagnostics[3] > 0 then
          return "%#TabLineHint#"
        elseif diagnostics[4] ~= nil and diagnostics[4] > 0 then
          return "%#TabLineInfo#"
        end
      end
    end
  end
  return ""
end

-- NOTE: Navigate tabs using 'gt' and 'gT'. To go to an indexed tab, use '<number>gt'.
local function gen_tab(id, is_active, padding)
  -- local index   = vim.api.nvim_tabpage_get_number(id)
  local windows = vim.api.nvim_tabpage_list_wins(id)
  local count   = #windows

  local window = vim.api.nvim_tabpage_get_win(id)
  local buffer = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window))
  -- Or use vim.fn.fnamemodify(buffer, ":t")
  local file   = vim.fs.basename(buffer)

  if file == "" then
    file = "New file"
  end

  -- file = pad(file, padding)
  if is_active then
    return colors.index .. " " .. count .. " " .. colors.active .. file .. " "
  else
    return colors.index_inactive .. " " .. count .. " "  .. colors.inactive
      .. get_diagnostic_hl(windows) .. file .. " "
  end
end

M.active = function()
  local tabs = vim.api.nvim_list_tabpages()
  local rendered = ""

  local t = vim.api.nvim_tabpage_get_number
  for _, tab in pairs(tabs) do
    rendered = rendered .. gen_tab(tab, t(0) == t(tab), 13) .. colors.default .. " "
  end

  -- TODO: Something on the right.
  return rendered .. colors.default
end

return M
