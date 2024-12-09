local M = {}

function M.setup()
  vim.opt.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"

  vim.api.nvim_create_autocmd({
    "WinEnter",
    "BufEnter"
  }, {
    group = "status",
    callback = function()
      if not vim.wo.number then
        vim.wo.statuscolumn = ""
      else
        vim.wo.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"
      end
    end
  })
end

M.sign = function()
  return "%s"
end

M.line_nr = function()
  if vim.v.relnum == 0 then
    return "%=" .. vim.v.lnum
  else
    return "%=" .. vim.v.relnum
  end
end

M.active = function()
  if not vim.wo.number then
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
