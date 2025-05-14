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
--- @param fn fun(...: any): any
--- @param ... any
--- @return any
function M.lib.with_args(fn, ...)
  local args = { ... }
  return function()
    return fn(unpack(args))
  end
end

--- Escape characters that may be interpreted as patterns.
--- @param str string
--- @return string
function M.lib.escape(str)
  return (str:gsub('[%^%$%(%)%%%.%[%]%*%+%-%?]', '%%%0'))
end

return M
