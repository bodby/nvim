local M = { }

function M.setup()
  -- For dashboard or first file opened.
  vim.wo.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"

  vim.api.nvim_create_autocmd({
    "BufEnter",
  }, {
    group    = "status",
    callback = function(event)
      local windows = vim.fn.win_findbuf(event.buf);

      for _, window in ipairs(windows) do
        vim.wo[window].statuscolumn =
          "%!v:lua.require('bodby.native.statuscolumn').active(" .. window .. ")"
      end
    end
  })
end

line_nr = function()
  -- https://github.com/mawkler/hml.nvim/blob/main/lua/hml/init.lua
  local top       = vim.fn.line "w0"
  local bottom    = vim.fn.line "w$"
  local middle    = math.floor((bottom - top) / 2 + top)

  local stc_H = top + vim.wo.scrolloff
  if top == 1 then
    stc_H = 1
  elseif stc_H > middle then
    stc_H = math.max(H, vim.wo.scrolloff)
  end

  local stc_M = math.max(middle, stc_H)

  local stc_L = bottom - vim.wo.scrolloff
  if bottom >= vim.fn.line "$" then
    stc_L = vim.fn.line "$"
  elseif stc_L < middle then
    stc_L = middle
  end

  local cur_line = vim.fn.line "."

  -- Wrapped lines and virtual lines.
  if vim.v.virtnum > 0 then
    return "%=+"
  elseif vim.v.virtnum < 0 then
    return "%=-"
  end

  if vim.v.relnum == 0 then
    return "%=" .. vim.v.lnum
  end

  if vim.v.lnum == stc_H then
    return "%=%#LineNrSpecial#H"
  elseif vim.v.lnum == stc_M then
    return "%=%#LineNrSpecial#M"
  elseif vim.v.lnum == stc_L then
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
    " %s",
    line_nr(),
    " "
  })
end

return M
