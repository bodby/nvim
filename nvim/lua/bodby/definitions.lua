-- Native shared types.

---@alias highlight string
---@alias module string

---@alias winID number
---@alias bufID number
---@alias tabID number

-- TODO: Implement.

---Config for native statusline.
---@class stl.config
---
---Whether the mode text should consist entirely of uppercase letters, lowercase letters, or only
---make the first character uppercase.
---This can also take in a function if you want to e.g. only capitalize certain filetypes.
---@field mode_casing "upper" | "lower" | "first" | fun(ft : string) : string
---
---The filetypes where the position, filetype, and line ending type modules shouldn't show.
---Blocks "alpha" and "TelescopePrompt" by default.
---@field blocked_filetypes string[]?
---
---The text to show for the filename of a new file.
---@field new_file_text string?
