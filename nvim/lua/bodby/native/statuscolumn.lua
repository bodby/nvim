local M = {
  highlights = {
    virtual = 'Virt',
    wrapped = 'Wrapped',
  },
}

--- Return a highlight string.
--- @param suffix string
--- @param cursor boolean
--- @return string
local function hl(suffix, cursor)
  return '%#' .. (cursor and 'CursorLineNr' or 'LineNr') .. suffix .. '#'
end

function M.setup()
  --- @param window integer
  local function expr(window)
    return '%!v:lua.require("bodby.native.statuscolumn").text(' .. window .. ')'
  end

  vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('status', { clear = false }),
    callback = function(_)
      local windows = vim.api.nvim_tabpage_list_wins(0)

      for _, window in pairs(windows) do
        -- Don't apply to floating windows.
        if vim.api.nvim_win_get_config(window).relative ~= '' then
          return
        end
        vim.wo[window].statuscolumn = expr(window)
      end
    end,
  })
end

--- Text used in the statuscolumn.
--- @param window integer
--- @return string
function M.text(window)
  if vim.api.nvim_win_is_valid(window) then
    if not vim.wo[window].number and not vim.wo[window].relativenumber then
      return ''
    end
  end

  local cursor = (vim.v.relnum == 0)
  local sign = '%s%='

  if vim.v.virtnum > 0 then
    return sign .. hl(M.highlights.wrapped, cursor) .. '| '
  elseif vim.v.virtnum < 0 then
    return sign .. hl(M.highlights.virtual, false) .. '- '
  end

  local highlight = hl('', cursor)

  if vim.v.relnum == 0 then
    return sign .. highlight .. tostring(vim.v.lnum) .. ' '
  end

  if vim.wo[window].relativenumber then
    return sign .. highlight .. tostring(vim.v.relnum) .. ' '
  else
    return sign .. highlight .. tostring(vim.v.lnum) .. ' '
  end
end

return M
