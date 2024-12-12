local M = {}

function M.setup()
  vim.wo.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"

  vim.api.nvim_create_autocmd({
    "BufWinEnter",
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

M.sign = function()
  return "%s"
end

M.line_nr = function()
  -- Wrapped and virtual line numbers.
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
  if not vim.wo[window].number or not vim.wo[window].relativenumber then
    return ""
  end

  return table.concat({
    " ",
    M.sign(),
    M.line_nr(),
    " "
  })
end

return M
