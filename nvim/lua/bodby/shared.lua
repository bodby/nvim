local M = {
  --- TODO: Icons.
  ui = {
    border = {
      name = 'rounded',
      characters = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
  },
  --- Helpful utility functions.
  lib = {},
}

--- Return whether the string passed is blank (`''`) or `nil`.
--- @param str string
--- @return boolean
function M.lib.nil_str(str)
  return not str or str == ''
end

--- Trim a string, returning it without any leading or trailing spaces.
--- @param str string
--- @return string
function M.lib.trim(str)
  return str:match('^%s*(.-)%s*$')
end

--- Call the passed function with arguments.
--- @generic T1
--- @generic T2
--- @param fn fun(...: T2): T1
--- @param ... T2
--- @return T2
function M.lib.with_args(fn, ...)
  local args = { ... }
  return function()
    return fn(unpack(args))
  end
end

return M
