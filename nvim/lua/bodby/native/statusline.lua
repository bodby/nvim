-- NOTE: 'else if' is not the same as 'elseif'.
local M = { }

local modes = {
  ["n"]  = "NO",
  ["no"] = "RO",
  ["v"]  = "VI",
  ["V"]  = "VL",
  [""] = "VB",
  ["s"]  = "SE",
  ["S"]  = "SL",
  [""] = "SB",
  ["i"]  = "IN",
  ["ic"] = "IN",
  ["R"]  = "RE",
  ["Rv"] = "RE",
  ["c"]  = "CM",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"]  = "PR",
  ["rm"] = "MR",
  ["r?"] = "??",
  ["!"]  = "VT",
  ["t"]  = "VT"
}

local colors = {
  mode           = "%#StatusLineMode#",
  pos            = "%#StatusLinePos#",
  syntax         = "%#StatusLineSyntax#",
  macro          = "%#StatusLineMacro#",
  file           = "%#StatusLineFile#",
  modified       = "%#StatusLineMod#",
  errors         = "%#StatusLineError#",
  warnings       = "%#StatusLineWarn#",
  hints_and_info = "%#StatusLineMisc#",

  git = {
    branch = "%#StatusLineGitBranch#",
    lines  = "%#StatusLineGitLines#"
  }
}

function M.setup()
  vim.opt.statusline = "%!v:lua.require('bodby.native.statusline').active()"

  -- Don't hide the statusline on certain actions.
  vim.api.nvim_create_autocmd({
    "BufWritePost",
    "BufEnter",
    "ColorScheme",
    "InsertEnter",
    "CmdwinLeave",
    "CmdlineLeave",
    "CmdlineChanged",
    "TextYankPost"
  }, {
    group    = "status",
    callback = function(_)
      vim.schedule(function()
        vim.cmd "redrawstatus"
      end)
    end
  })

  if vim.g.neovide then
    vim.api.nvim_create_autocmd({
      "CmdwinEnter",
      "CmdlineEnter",
    }, {
      group    = "status",
      callback = function(_)
        vim.opt.statusline = " "
      end
    })

    vim.api.nvim_create_autocmd({
      "CmdwinLeave",
      "CmdlineLeave",
    }, {
      group    = "status",
      callback = function(_)
        vim.opt.statusline = "%!v:lua.require('bodby.native.statusline').active()"
      end
    })
  end
end

-- Shows the current mode.
local stl_mode = function()
  local cur_mode = modes[vim.api.nvim_get_mode().mode]

  if cur_mode ~= nil then
    return colors.mode .. " " .. cur_mode .. " "
  else
    return colors.mode .. " ?? "
  end
end

-- Shows the current file and a modified symbol.
local stl_file = function()
  local modified = ""
  if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
    modified = colors.modified .. "'"
  end

  if vim.fn.expand "%<%f" == "" then
    return colors.file .. "@" .. vim.env.USER .. modified .. "%#StatusLine# "
  else
    return colors.file .. "%<%f" .. modified .. "%#StatusLine# "
  end
end

-- The (#branch +L ~L -L) in the stl.
-- TODO: This requires gitsigns.nvim. I should probably write this as a standalone function using
--       only Git commands.
local stl_git_info = function()
  local branch = (vim.b.gitsigns_head ~= nil and "#" .. vim.b.gitsigns_head .. " " or "")

  local status = (vim.b.gitsigns_status ~= "" and vim.b.gitsigns_status ~= nil
    and vim.b.gitsigns_status .. " " or "")

  return colors.git.branch .. branch .. colors.git.lines .. status
end

-- Shows macro register if recording.
local stl_macro = function()
  return colors.macro .. vim.fn.reg_recording() .. " "
end

-- Shows current line and column as well as percentage of whole file.
local stl_pos = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return colors.pos .. row .. ":" .. col .. "%#StatusLine# " .. colors.mode .. " %p%% "
end

-- Errors, warnings, and hints and info (in one number).
local stl_diagnostics = function()
  local count = vim.diagnostic.count(0)

  local errors = ""
  if count[1] ~= nil then
    errors = colors.errors .. count[1] .. " "
  end

  local warnings = ""
  if count[2] ~= nil then
    warnings = colors.warnings .. count[2] .. " "
  end

  local hints = 0
  local info  = 0
  if count[3] ~= nil then hints = hints + 1 end
  if count[4] ~= nil then info = info + 1 end

  local hints_and_info = ""
  if hints ~= 0 or info ~= 0 then
    hints_and_info = colors.hints_and_info .. hints + info .. " "
  end

  return " " .. errors .. warnings .. hints_and_info
end

M.active = function()
  return table.concat({
    stl_mode(),
    "%#StatusLine# ",
    stl_file(),
    stl_git_info(),
    stl_macro(),
    "%#StatusLine#%=",
    stl_diagnostics(),
    stl_pos()
  })
end

return M
