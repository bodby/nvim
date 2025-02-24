local M = { }

function M.setup()
  -- For dashboard or first file opened.
  vim.wo.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"

  vim.api.nvim_create_autocmd({
    "WinEnter",
    "BufEnter",
  }, {
    group    = "status",
    callback = function(event)
      local windows = vim.api.nvim_tabpage_list_wins(0);

      for _, window in pairs(windows) do
        if vim.api.nvim_win_get_config(window).relative ~= "" then
          return
        end

        vim.wo[window].statuscolumn =
          "%!v:lua.require('bodby.native.statuscolumn').active(" .. window .. ")"
      end
    end
  })
end

local line_nr = function(window)
  -- https://github.com/mawkler/hml.nvim/blob/main/lua/hml/init.lua
  local top    = vim.fn.getwininfo(window)[1].topline
  local bottom = vim.fn.getwininfo(window)[1].botline
  local middle = math.floor((bottom - top) / 2 + top)

  local scrolloff = vim.wo[window].scrolloff
  local buffer    = vim.api.nvim_win_get_buf(window)

  local h = top + scrolloff
  if top == 1 then
    h = 1
  elseif h > middle then
    h = math.max(h, scrolloff)
  end

  local m = math.max(middle, h)

  local l = bottom - scrolloff
  if bottom >= vim.fn.getbufinfo(buffer)[1].linecount then
    l = vim.fn.getbufinfo(buffer)[1].linecount
  elseif l < middle then
    l = middle
  end

  -- Wrapped lines.
  if vim.v.virtnum > 0 then
    if vim.v.relnum == 0 then
      return "%#CursorLineNrWrapped#%=│"
    end
    return "%#LineNrWrapped#%=│"
  elseif vim.v.virtnum < 0 then
    -- Virtual lines.
    return "%#LineNrWrapped#%=│"
  end

  if vim.v.relnum == 0 then
    return "%=" .. vim.v.lnum
  end

  if vim.v.lnum == h then
    return "%=%#LineNrSpecial#H"
  elseif vim.v.lnum == m then
    return "%=%#LineNrSpecial#M"
  elseif vim.v.lnum == l then
    return "%=%#LineNrSpecial#L"
  end

  return "%=" .. vim.v.relnum
end

M.active = function(window)
  -- HACK: Checking for validity before actually checking options.
  --       If I don't do this then deleting windows throws an error.
  if vim.api.nvim_win_is_valid(window) then
    if not vim.wo[window].number or not vim.wo[window].relativenumber then
      return ""
    end
  end

  return table.concat({
    "%s",
    line_nr(window),
    " "
  })
end

return M
