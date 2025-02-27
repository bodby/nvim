local M = { }

---@alias tabline string

-- FIXME: 'EntryError' and 'EntryErrorNC' while the right side of the tabline just uses 'Error'.
--        Entry diagnostic highlights are broken right now.
M.colors = {
  tab   = "Entry",
  index = "Index",
  loc   = "LineCount",
  count = "Count",
  error = "Error",
  warn  = "Warn",
  info  = "Info",
  hint  = "Hint"
}

local hl_reset = "%#TabLine#"

---@param col string Color name
---@param current boolean? Whether to append NC to the highlight
---@return highlight
local function tabl_hl(col, current)
  if current == nil then current = true end

  local c = current and "" or "NC"
  return "%#TabLine" .. col .. c .. "#"
end

-- TODO: Use this somewhere.
--[[
  ---Add spaces after 'str' to make it have the length 'max'.
  ---Returns the string as-is if it is already long enough.
  ---@param str string
  ---@param max number
  ---@return string
  local function pad(str, max)
    return str .. string.rep(" ", math.max(max - str:len(), 0))
  end
]]

---Check every window to see if any of them have any diagnostics and return the necessary color.
---@param windows winID[]
---@param current boolean
---@return string
local function diagnostic_hl(windows, current)
  ---@param hl string
  ---@return highlight
  local function diag_fmt(hl)
    return tabl_hl(M.colors.tab .. hl, current)
  end

  for _, win in ipairs(windows) do
    if vim.api.nvim_win_is_valid(win) then
      local diagnostics = vim.diagnostic.count(vim.api.nvim_win_get_buf(win))

      if next(diagnostics) ~= nil then
        if diagnostics[1] ~= nil and diagnostics[1] > 0 then
          return diag_fmt(M.colors.error)
        elseif diagnostics[2] ~= nil and diagnostics[2] > 0 then
          return diag_fmt(M.colors.warn)
        elseif diagnostics[3] ~= nil and diagnostics[3] > 0 then
          return diag_fmt(M.colors.info)
        elseif diagnostics[4] ~= nil and diagnostics[4] > 0 then
          return diag_fmt(M.colors.hint)
        end
      end
    end
  end

  return ""
end

-- TODO: Take in an opts table.
function M.setup()
  vim.o.tabline = "%!v:lua.require('bodby.native.tabline').active()"
end

---Generate a module for the passed tab ID.
---@param tab tabID
---@param current boolean
---@return module
local function gen_tab(tab, current)
  local windows = vim.api.nvim_tabpage_list_wins(tab)

  local valid = 0
  for _, win in ipairs(windows) do
    -- Don't include floating windows (autocomplete, Telescope, etc.) in the displayed number.
    if vim.api.nvim_win_get_config(win).relative == "" then
      valid = valid + 1
    end
  end

  local window = vim.api.nvim_tabpage_get_win(tab)
  local buffer = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window))
  local file   = vim.fs.basename(buffer)

  if file == "" then
    file = "New file"
  end

  return table.concat({
    tabl_hl(M.colors.count, current),
    " ",
    valid,
    " ",
    tabl_hl(M.colors.tab, current),
    diagnostic_hl(windows, current),
    file,
    " "
  })
end

---Return the diagnostics of all the windows open in every tab.
---@return module
local function diagnostics()
  local count = vim.diagnostic.count()

  ---@param num number
  ---@param hl string
  ---@return highlight
  local function diag_fmt(num, hl)
    return count[num] ~= nil and (tabl_hl(hl) .. " " .. count[num]) or ""
  end

  local errors   = diag_fmt(1, M.colors.error)
  local warnings = diag_fmt(2, M.colors.warn)
  local info     = diag_fmt(3, M.colors.info)
  local hints    = diag_fmt(4, M.colors.hint)

  return errors .. warnings .. hints .. info
end

---Show the current tab index.
---I just needed something to always be visible on the right.
---@return module
local function index()
  return tabl_hl(M.colors.index) .. " " .. vim.api.nvim_tabpage_get_number(0) .. " "
end

---Show the line count of the current buffer.
---@param tab tabID
---@return module
local function line_count(tab)
  local window = vim.api.nvim_tabpage_get_win(tab)
  local buffer = vim.api.nvim_win_get_buf(window)

  local lcount = vim.fn.getbufinfo(buffer)[1].linecount
  if lcount ~= nil then
    return tabl_hl(M.colors.loc) .. " " .. lcount
  else
    return ""
  end
end

---Actual tabline used in 'vim.o.tabline'.
---@return tabline
function M.active()
  local tabs = vim.api.nvim_list_tabpages()
  local rendered = ""

  local ti = vim.api.nvim_tabpage_get_number
  for _, tab in pairs(tabs) do
    rendered = rendered .. gen_tab(tab, ti(0) == ti(tab))
  end

  return rendered .. hl_reset .. "%=" .. diagnostics() .. line_count(0) .. index()
end

return M
