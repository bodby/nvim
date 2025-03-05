--- @type table<string, any>
local options = {
  pumheight = 16,
  scrolloff = 12,
  cmdheight = 0,
  wrap = true,
  conceallevel = 0,
  concealcursor = "",

  number = true,
  relativenumber = true,
  cursorline = true,
  numberwidth = 1,
  signcolumn = "yes",
  laststatus = 3,
  showtabline = 2,

  hlsearch = false,
  ignorecase = true,
  smartcase = true,

  guicursor = "a:Cursor/Cursor",
  linespace = 6,

  confirm = true,
  undofile = true,
  undolevels = 10000,
  shortmess = "oOstTWIcCFSqc",

  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,

  list = true,
  fillchars = "eob: ,fold: ",
  listchars = "tab:> ,trail:_"
}

--- Global options prefixed with "neovide_".
--- @type table<string, any>
local neovide_options = {
  -- TODO: Make font thinner.
  text_gamma = 1.2,
  text_contrast = 0.0,

  padding_top = 24,
  padding_right = 24,
  padding_bottom = 24,
  padding_left = 24,

  cursor_unfocused_outline_width = 0,

  confirm_quit = true,
  no_idle = false,

  floating_shadow = false,
  floating_corner_radius = 0,
  floating_blur_amount_x = 0,
  floating_blur_amount_y = 0,

  position_animation_length = 0.2,
  scroll_animation_length = 0.2,
  scroll_animation_far_lines = 0,
  cursor_animation_length = 0.06,
  cursor_trail_size = 0.4,
  cursor_animate_in_insert_mode = true,
  cursor_animate_command_line = true
}

for k, v in pairs(options) do
  vim.o[k] = v
end

if vim.g.neovide then
  for k, v in pairs(neovide_options) do
    vim.g["neovide_" .. k] = v
  end
end
