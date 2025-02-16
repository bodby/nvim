-- NOTE: 'else if' is not the same as 'elseif'.
-- TODO: Refactor this entire file because everything in it is ugly right now.
local M = { }

local modes = {
  ["n"]  = "Normal",
  ["no"] = "Normal",
  ["v"]  = "Visual",
  ["V"]  = "Visual",
  [""] = "Visual",
  ["s"]  = "Select",
  ["S"]  = "Select",
  [""] = "Select",
  ["i"]  = "Insert",
  ["ic"] = "Insert",
  ["R"]  = "Replace",
  ["Rv"] = "Replace",
  ["c"]  = "Command",
  ["cv"] = "Command",
  ["r"]  = "Prompt",
  ["rm"] = "Prompt",
  ["r?"] = "Prompt",
  ["!"]  = "Shell",
  ["t"]  = "Shell"
}

local mode_hls = {
  ["n"]  = "Purple",
  ["no"] = "Gray",
  ["v"]  = "Green",
  ["V"]  = "Green",
  [""] = "Green",
  ["s"]  = "Green",
  ["S"]  = "Green",
  [""] = "Green",
  ["i"]  = "Cyan",
  ["ic"] = "Cyan",
  ["R"]  = "Red",
  ["Rv"] = "Red",
  ["c"]  = "Yellow",
  ["cv"] = "Yellow",
  ["r"]  = "Yellow",
  ["rm"] = "Yellow",
  ["r?"] = "Yellow",
  ["!"]  = "Gray",
  ["t"]  = "Gray"
}

local colors = {
  pos            = "%#StatusLinePos#",
  syntax         = "%#StatusLineSyntax#",
  macro          = "%#StatusLineMacro#",
  file           = "%#StatusLineFile#",
  filetype       = "%#StatusLineFileType#",
  newline        = "%#StatusLineNewLine#",
  errors         = "%#StatusLineError#",
  warnings       = "%#StatusLineWarn#",
  hints_and_info = "%#StatusLineMisc#",

  git = {
    branch = "%#StatusLineGitBranch#",
    lines  = "%#StatusLineGitLines#"
  }
}

local blocked_fts = {
  "alpha",
  "TelescopePrompt"
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
local stl_mode = function(show_name)
  -- TODO: Move both of these into a single table with a tuple.
  local cur_mode = modes[vim.api.nvim_get_mode().mode]
  local mode_hl  = mode_hls[vim.api.nvim_get_mode().mode]

  if cur_mode then cur_mode = cur_mode:lower() end

  if mode_hl ~= nil then
    if show_name and cur_mode ~= nil then
      return "%#StatusLine" .. mode_hl .. "# " .. "%#StatusLineMode# :" .. cur_mode .. " "
    else
      return "%#StatusLine" .. mode_hl .. "# "
    end
  else
    if show_name then
      return "%#StatusLineGray# %#StatusLineMode# :limbo "
    else
      return "%#StatusLineGray# "
    end
  end
end

-- Shows the current file and a modified symbol.
local stl_file = function()
  -- FIXME: Check if vim.go.columns minus the (sum of all the lengths and the basename of the path)
  -- is less than 0. If so, it means the filename does not fit.
  -- Do the same with the full path (after fnamemodify), and not the basename.
  local fname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

  if vim.go.columns >= 70 and fname ~= "" then
    local spacing = "%#StatusLine# "

    local modified = ""
    if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
      modified = "'"
    end

    if vim.go.columns <= 100 then
      fname = vim.fs.basename(fname)
    else
      fname = vim.fn.fnamemodify(fname, ":.")
    end

    return colors.file .. " " .. fname .. modified .. " " .. spacing
  else
    return ""
  end
end

-- The (#branch +L ~L -L) in the stl.
-- TODO: This requires gitsigns.nvim. I should probably write this as a standalone function using
--       only Git commands.
local stl_git_info = function()
  local spacing = ""

  local branch = (vim.b.gitsigns_head ~= nil and " #" .. vim.b.gitsigns_head .. " " or "")
  local status = (vim.b.gitsigns_status ~= "" and vim.b.gitsigns_status ~= nil
    and vim.b.gitsigns_status .. " " or "")

  if branch ~= "" or status ~= "" then
    spacing = "%#StatusLine# "
  end
  return colors.git.branch .. branch .. colors.git.lines .. status .. spacing
end

-- Shows macro register if recording.
local stl_macro = function()
  if vim.fn.reg_recording() ~= "" then
    return colors.macro .. " " .. vim.fn.reg_recording() .. " "
  else
    return "%#StatusLine#"
  end
end

-- Shows current line and column as well as percentage of whole file.
local stl_pos = function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return colors.pos .. " " .. row .. ":" .. col .. " %p%% "
end

-- Errors, warnings, and hints and info (in one number).
local stl_diagnostics = function()
  local count = vim.diagnostic.count(0)

  local errors = ""
  if count[1] ~= nil then
    errors = colors.errors .. " " .. count[1]
  end

  local warnings = ""
  if count[2] ~= nil then
    warnings = colors.warnings .. " " .. count[2]
  end

  local hints = 0
  local info  = 0
  if count[3] ~= nil then hints = hints + 1 end
  if count[4] ~= nil then info = info + 1 end

  local hints_and_info = ""
  if hints ~= 0 or info ~= 0 then
    hints_and_info = colors.hints_and_info .. " " .. hints + info
  end

  local spacing = ""
  -- :(
  if errors ~= "" or warnings ~= "" or hints_and_info ~= "" then
    spacing = " "
  end

  return errors .. warnings .. hints_and_info .. colors.errors .. spacing
end

-- 3 billion download JS micro-dependency.
local function elem(e, xs)
  for _, v in ipairs(xs) do
    if v == e then return true end
  end
  return false
end

local stl_filetype = function()
  local ft       = vim.bo.filetype
  local newlines = vim.bo.fileformat

  if elem(ft, blocked_fts) then
    return colors.filetype .. ""
  elseif ft == "" then
    return colors.filetype .. " !none " .. colors.newline .. newlines .. " "
  else
    -- return colors.filetype .. ft:gsub("^%l", string.upper) .. " "
    return colors.filetype .. " !" .. ft .. " " .. colors.newline .. newlines .. " "
  end
end

local spacing = "%#StatusLine# "

M.active = function()
  return table.concat({
    stl_mode(true),
    spacing,
    stl_file(),
    stl_git_info(),
    stl_macro(),
    "%#StatusLine#%=",
    stl_diagnostics(),
    spacing,
    stl_filetype(),
    spacing,
    stl_pos(),
    stl_mode(false)
  })
end

return M
