local M = { }

local colors = {
  default        = "%#TabLine#",
  fill           = "%#TabLineFill#",
  active         = "%#TabLineSel#",
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

local function pad(str, max)
  if not str then return "NOO" end
  if str:len() >= max then return str end

  local padding = ""
  for x = 1, max - str:len(), 1 do
    padding = padding .. " "
  end

  return str .. padding
end

-- NOTE: Navigate tabs using 'gt' and 'gT'. To go to an indexed tab, use '<number>gt'.
local function gen_tab(id, is_active, padding)
  -- local index = vim.api.nvim_tabpage_get_number(id)
  local count = #vim.api.nvim_tabpage_list_wins(id)

  -- Or use vim.fn.fnamemodify(buffer_fname, ":t")
  local window = vim.api.nvim_tabpage_get_win(id)
  local buffer = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window))
  local file = vim.fs.basename(buffer)

  if file == "" then
    file = "New file"
  end

  -- file = pad(file, padding)
  if is_active then
    return colors.index .. " " .. count .. " " .. colors.active .. file .. " "
  else
    return colors.index_inactive .. " " .. count .. " "  .. colors.default .. file .. " "
  end
end

M.active = function()
  local tabs = vim.api.nvim_list_tabpages()
  local rendered = ""

  local t = vim.api.nvim_tabpage_get_number
  for _, tab in pairs(tabs) do
    rendered = rendered .. gen_tab(tab, t(0) == t(tab), 13)
  end

  -- TODO: Something on the right.
  return rendered .. colors.fill
end

return M
