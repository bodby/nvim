local M = {}

M = {
  col = {
    default = "%#StatusLine#",
    mode = "%#StatusLineMode#",
    pos = "%#StatusLinePos#",
    macro = "%#StatusLineMacro#",
    file = "%#StatusLineFile#",
    modified = "%#StatusLineMod#",
    errors = "%#StatusLineError#",
    warnings = "%#StatusLineWarn#",
    hints_and_info = "%#StatusLineMisc#"
  },
  modes = {
    ["n"] = "N",
    ["no"] = "N",
    ["v"] = "V",
    ["V"] = "V",
    [""] = "V",
    ["s"] = "S",
    ["S"] = "S",
    [""] = "S",
    ["i"] = "I",
    ["ic"] = "I",
    ["R"] = "R",
    ["Rv"] = "R",
    ["c"] = "C",
    ["cv"] = "E",
    ["ce"] = "E",
    ["r"] = "P",
    ["rm"] = "M",
    ["r?"] = "?",
    ["!"]  = "T",
    ["t"]  = "T"
  },
  modified_char = "'"
}

function M.setup()
  vim.opt.statusline = "%!v:lua.require('bodby.native.statusline').active()"

  vim.api.nvim_create_augroup("statusline", {})
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertEnter", "CmdwinLeave", "CmdlineLeave", "TextYankPost" }, {
    group = "statusline",
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
    return M.col.mode .. " ? "
  end
end

-- Shows total LOC in file.
-- function M.loc()
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
-- function M.git_info()
-- return M.col.git .. vim.b.gitsigns_status .. " "
-- end

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

  local errors = ""
  local warnings = ""
  local hints_and_info = ""

  if count["errors"] ~= 0 then
    errors = M.col.errors .. count["errors"] .. " "
  end

  if count["warnings"] ~= 0 then
    warnings = M.col.warnings .. count["warnings"] .. " "
  end

  if count["info"] ~= 0 or count["hints"] ~= 0 then
    hints_and_info = M.col.hints_and_info .. (count["hints"] + count["info"]) .. " "
  end

  return errors .. warnings .. hints_and_info
end

M.active = function()
  return table.concat({
    M.col.default,
    M.mode(),
    M.col.default,
    " ",
    M.file(),
    -- git_info(),
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
