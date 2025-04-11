local M = {
  --- TODO: Icons.
  ui = {
    transparent = true,
    border = {
      name = 'rounded',
      -- characters = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      characters = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
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
--- This acts only on spaces, not tabs.
--- @param str string
--- @return string
function M.lib.trim(str)
  local i1, i2 = 1, #str
  while str:sub(i1, i1) == ' ' do
    i1 = i1 + 1
  end
  while str:sub(i2, i2) == ' ' do
    i2 = i2 - 1
  end
  return str:sub(i1, i2)
  -- if M.lib.nil_str(str) then
  --   return ''
  -- else
  --   return str:match('^%s*(.-)%s*$')
  -- end
end

--- Insert all passed elements into an array.
--- @generic T
--- @param xs T[]
--- @param ... T
--- @return T[]
function M.lib.insert_elems(xs, ...)
  local result = xs
  for _, v in ipairs({ ... }) do
    table.insert(result, v)
  end
  return result
end

--- Return a lambda that calls the passed function with the passed arguments.
--- This allows you to pass functions with arguments, rather than just the
--- function as-is.
--- If the passed function has a return value, then it is also returned.
---
--- I don't know how to describe this, honestly.
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

--- Reverse the order of a list's elements.
--- @generic T
--- @param t T[]
--- @return T[]
function M.lib.reverse(t)
  local result = t
  for i1 = 1, math.floor(#t / 2) do
    local i2 = #t - i1 + 1
    t[i1], t[i2] = t[i2], t[i1]
  end
  return result
end

return M
