local M = {
  mappings = {},
  strings = {},
}

--- Create mappings for each element in a table, grouped by mode.
--- @param t table<string, table<string, string | fun()>>
--- @param opts? table
function M.mappings.map(t, opts)
  for mode, v in pairs(t) do
    local modes = vim.split(mode, '')
    for lhs, rhs in pairs(v) do
      vim.keymap.set(modes, lhs, rhs, opts or {})
    end
  end
end

--- Return whether the string passed is blank (`''`) or `nil`.
--- @param str string
--- @return boolean
function M.nil_str(str)
  return not str or str == ''
end

--- Trim a string, returning it without any leading or trailing spaces.
--- @param str string
--- @return string
function M.strings.trim(str)
  return str:match('^%s*(.-)%s*$')
end

--- Call the passed function with arguments.
--- @param fn fun(...: any): any
--- @param ... any
--- @return any
function M.with_args(fn, ...)
  local args = { ... }
  return function()
    return fn(unpack(args))
  end
end

--- Escape characters that may be interpreted as patterns.
--- @param str string
--- @return string
function M.strings.escape(str)
  return (str:gsub('[%^%$%(%)%%%.%[%]%*%+%-%?]', '%%%0'))
end

return M
