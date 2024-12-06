local M = {}

function M.setup()
  vim.opt.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"

  vim.api.nvim_create_autocmd({
    "BufEnter",
    "UIEnter"
  }, {
    group = "status",
    callback = function()
      vim.schedule(function()
        if vim.bo.filetype == "alpha" then
          vim.opt.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').inactive()"
        else
          vim.opt.statuscolumn = "%!v:lua.require('bodby.native.statuscolumn').active()"
        end
      end)
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
  if vim.wo.number == false then
    return ""
  end

  return table.concat({
    " ",
    M.sign(),
    M.line_nr(),
    " "
  })
end

-- Used in the dashboard.
M.inactive = function()
  return ""
end

return M
