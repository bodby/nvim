local M = {
  col = {
    default = "%#StatusLine#",
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
  },
  modes = {
    ["n"] = "RW",
    ["no"] = "RO",
    ["v"] = "**",
    ["V"] = "**",
    [""] = "**",
    ["s"] = "SE",
    ["S"] = "SL",
    [""] = "SB",
    ["i"] = "**",
    ["ic"] = "**",
    ["R"] = "**",
    ["Rv"] = "**",
    ["c"] = "CM",
    ["cv"] = "EX",
    ["ce"] = "EX",
    ["r"] = "PR",
    ["rm"] = "MR",
    ["r?"] = "??",
    ["!"] = "VT",
    ["t"] = "VT"
  },
  modified_char = "'"
}

function M.setup()
  vim.opt.statusline = "%!v:lua.require('bodby.native.statusline').active()"

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

M.mode = function()
  local cur_mode = M.modes[vim.api.nvim_get_mode().mode]

  if cur_mode ~= nil then
    return M.col.mode .. " " .. cur_mode .. " "
  else
    return M.col.mode .. " ?? "
  end
end

-- Shows total LOC in file.
-- M.loc = function()
--   return M.col.pos .. vim.fn.line "$"
-- end

M.file = function()
  local modified = ""
  if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
    modified = M.col.modified .. M.modified_char
  end

  if vim.fn.expand "%<%f" == "" then
    return M.col.file .. vim.env.USER .. modified .. " "
  else
    return M.col.file .. "%<%f" .. modified .. " "
  end
end

-- Shows no. of lines added, modified, and removed.
-- Formatted as (+L ~L -L).
M.git_info = function()
  local lines = M.col.git.lines .. (vim.b.gitsigns_status ~= nil and vim.b.gitsigns_status or "")
  local branch = M.col.git.branch .. (vim.b.gitsigns_head ~= nil and "#" .. vim.b.gitsigns_head or "")

  if branch ~= "" and lines ~= "" then
    lines = " " .. lines
  end

  local left_parenthesis = ""
  local right_parenthesis = ""
  if lines ~= "" or branch ~= "" then
    left_parenthesis = "("
    right_parenthesis = ")"
  end

  return M.col.syntax .. left_parenthesis .. branch .. lines .. M.col.syntax .. right_parenthesis .. " "
end

-- Shows macro register if recording.
M.macro = function()
  return M.col.macro .. vim.fn.reg_recording()
end

-- Shows current line and column.
M.pos = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return M.col.pos .. row .. ":" .. col
end

-- Errors, warnings, and hints and info (in one number).
M.diagnostics = function()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    hints = "Hint",
    info = "Info"
  }

  -- Populate count table with diagnostic numbers.
  for i, v in pairs(levels) do
    count[i] = vim.tbl_count(vim.diagnostic.get(0, { serverity = level }))
  end

  local errors = M.col.errors .. count["errors"] .. " "
  local warnings = M.col.warnings .. count["warnings"] .. " "
  local hints_and_info = M.col.hints_and_info .. (count["hints"] + count["info"]) .. " "

  return errors .. warnings .. hints_and_info
end

M.active = function()
  return table.concat({
    M.col.default,
    M.mode(),
    M.col.default,
    " ",
    M.file(),
    M.git_info(),
    M.macro(),
    M.col.default,
    -- Right align.
    "%=",
    M.diagnostics(),
    -- loc(),
    M.pos()
  })
end

return M
