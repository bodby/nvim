local M = {}

local modes = {
  ["n"] = "NO",
  ["no"] = "RO",
  ["v"] = "VI",
  ["V"] = "VL",
  [""] = "VB",
  ["s"] = "SE",
  ["S"] = "SL",
  [""] = "SB",
  ["i"] = "IN",
  ["ic"] = "IN",
  ["R"] = "RE",
  ["Rv"] = "RE",
  ["c"] = "CM",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "PR",
  ["rm"] = "MR",
  ["r?"] = "??",
  ["!"] = "VT",
  ["t"] = "VT"
}

local colors = {
  mode = "%#StatusLineMode#",
  pos = "%#StatusLinePos#",
  syntax = "%#StatusLineSyntax#",
  git = {
    branch = "%#StatusLineGitBranch#",
    lines = "%#StatusLineGitLines#"
  },
  macro = "%#StatusLineMacro#",
  file = "%#StatusLineFile#",
  modified = "%#StatusLineMod#",
  errors = "%#StatusLineError#",
  warnings = "%#StatusLineWarn#",
  hints_and_info = "%#StatusLineMisc#"
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
    group = "status",
    callback = function(_)
      vim.schedule(function()
        vim.cmd "redrawstatus"
      end)
    end
  })
end

-- Shows the current mode.
stl_mode = function()
  local cur_mode = modes[vim.api.nvim_get_mode().mode]

  if cur_mode ~= nil then
    return colors.mode .. " " .. cur_mode .. " "
  else
    return colors.mode .. " ?? "
  end
end

-- Shows the current file and a modified symbol.
stl_file = function()
  local modified = ""
  if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
    modified = colors.modified .. "'"
  end

  if vim.fn.expand "%<%f" == "" then
    return colors.file .. "@" .. vim.env.USER .. modified .. " "
  else
    return colors.file .. "%<%f" .. modified .. " "
  end
end

-- The (#branch +L ~L -L) in the stl.
stl_git_info = function()
  local lines = colors.git.lines
    .. (vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status or "")
  local branch = colors.git.branch
    .. (vim.b.gitsigns_head ~= nil and "#" .. vim.b.gitsigns_head or "")

  if branch ~= colors.git.branch and lines ~= colors.git.lines then
    lines = " " .. lines
  end

  local left_parenthesis = ""
  local right_parenthesis = ""
  if branch ~= colors.git.branch or lines ~= colors.git.lines then
    left_parenthesis = "("
    right_parenthesis = ") "
  end

  return colors.syntax .. left_parenthesis .. branch .. lines
    .. colors.syntax .. right_parenthesis
end

-- Shows macro register if recording.
stl_macro = function()
  return colors.macro .. vim.fn.reg_recording()
end

-- Shows current line and column.
stl_pos = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return colors.pos .. row .. ":" .. col
end

-- Errors, warnings, and hints and info (in one number).
stl_diagnostics = function()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    hints = "Hint",
    info = "Info"
  }

  for i, v in pairs(levels) do
    count[i] = vim.tbl_count(vim.diagnostic.get(0, { serverity = level }))
  end

  local errors = ""
  if count["errors"] ~= 0 then
    errors = colors.errors .. count["errors"] .. " "
  end

  local warnings = ""
  if count["warnings"] ~= 0 then
    warnings = colors.warnings .. count["warnings"] .. " "
  end

  local hints_and_info = ""
  if count["hints"] ~= 0 or count["info"] ~= 0 then
    hints_and_info = colors.hints_and_info .. (count["hints"] + count["info"]) .. " "
  end

  return errors .. warnings .. hints_and_info
end

M.active = function()
  return table.concat({
    stl_mode(),
    "%##",
    " ",
    stl_file(),
    stl_git_info(),
    stl_macro(),
    "%=",
    stl_diagnostics(),
    stl_pos()
  })
end

return M
