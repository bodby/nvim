local M = { }

--- @alias highlight string
--- @alias module string
--- @alias tabline string
--- @alias diagnosticID number
--- @alias tabID number

-- FIXME: 'EntryError' and 'EntryErrorNC' while the right side of the tabline just uses 'Error'.
--        Entry diagnostic highlights are broken right now.
M.colors = {
  tab     = "Entry",
  index   = "Index",
  count   = "Count",
  error   = "Error",
  warning = "Warn",
  info    = "Info",
  hint    = "Hint"
}

local hl_reset = "%#TabLine#"

--- @param col string Color name
--- @param current bool? Whether to append NC to the highlight
--- @return highlight Usable tabline highlight string surrounded by "%#...#"
local function tabl_hl(col, current)
  if current == nil then current = true end

  local c = current and "" or "NC"
  return "%#TabLine" .. col .. c .. "#"
end

--- Add spaces after 'str' to make it have the length 'max'.
--- Returns the string as-is if it is already long enough.
--- @param str string
--- @param max number
--- @return string
local function pad(str, max)
  -- TODO: Use this somewhere.
  return str .. string.rep(" ", math.max(max - str:len(), 0))
end

--- Check every window to see if any of them have any diagnostics and return the necessary color.
--- @param windows windowID[]
--- @return string
local function diagnostic_hl(windows)
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


-- TODO: Take in an opts table.
function M.setup()
  vim.opt.tabline = "%!v:lua.require('bodby.native.tabline').active()"

  -- vim.api.nvim_create_autocmd({
  --   "TabNew",
  --   "TabClosed"
  -- }, {
  --   group    = "status",
  --   callback = function(event)
  --     vim.schedule(function()
  --       vim.opt.tabline = "%!v:lua.require('bodby.native.tabline').active()"
  --     end)
  --   end
  -- })
end

--- Generate a module for the passed tab ID.
--- @param tab tabID
--- @param current bool
--- @return module
local function gen_tab(tab, current)
  -- NOTE: Navigate tabs using 'gt' and 'gT'. To go to an indexed tab, use '<number>gt'.

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
    diagnostic_hl(windows),
    file,
    " "
  })
end

--- Return the diagnostics of all the windows open in every tab.
--- @return module
local diagnostics = function()
  local count = vim.diagnostic.count()

  local errors   = count[1] ~= nil and (tabl_hl(M.colors.error) .. count[1]) or ""
  local warnings = count[2] ~= nil and (tabl_hl(M.colors.warning) .. " " .. count[2]) or ""
  local info     = count[3] ~= nil and (tabl_hl(M.colors.info) .. " " ..count[3]) or ""
  local hints    = count[4] ~= nil and (tabl_hl(M.colors.hint) .. " " ..count[4]) or ""

  local spacing = ""
  if #count > 0 then spacing = tabl_hl(M.colors.error) .. " " end

  return spacing .. errors .. warnings .. hints .. info .. spacing
end

--- Show the current tab index.
--- I just needed something to always be visible on the right.
--- @return module
local index = function()
  return tabl_hl(M.colors.index) .. " " .. vim.api.nvim_tabpage_get_number(0) .. " "
end

--- Actual tabline used in 'vim.opt.tabline'.
--- @return tabline
M.active = function()
  local tabs = vim.api.nvim_list_tabpages()
  local rendered = ""
  -- Errors, warnings, hints, and info.
  local diag_count = { 0, 0, 0, 0 }

  local t = vim.api.nvim_tabpage_get_number
  for _, tab in pairs(tabs) do
    rendered = rendered .. gen_tab(tab, t(0) == t(tab))
  end

  return rendered .. hl_reset .. "%=" .. diagnostics() .. index()
end

return M
