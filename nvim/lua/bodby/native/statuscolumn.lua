local M = {}

function M.setup()
  -- For dashboard or first file opened.
  vim.wo.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"

  vim.api.nvim_create_autocmd({
    "BufEnter",
  }, {
    group = "status",
    callback = function(event)
      local windows = vim.fn.win_findbuf(event.buf);

      for _, window in ipairs(windows) do
        vim.wo[window].statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active(" .. window .. ")"
      end
    end
  })
end

M.line_nr = function()
  -- Wrapped lines and virtual lines.
  if vim.v.virtnum > 0 then
    return "%=+"
  elseif vim.v.virtnum < 0 then
    return "%=-"
  end

  if vim.v.relnum == 0 then
    return "%=" .. vim.v.lnum
  else
    return "%=" .. vim.v.relnum
  end
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
    M.line_nr(),
    " "
  })
end

return M
