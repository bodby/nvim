vim.opt.pumheight      = 16
vim.opt.scrolloff      = 8
vim.opt.showmode       = false
vim.opt.cmdheight      = 0
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.numberwidth    = 1
vim.opt.signcolumn     = "yes"
vim.opt.wrap           = true
vim.opt.hlsearch       = false
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.spelllang      = "en"
vim.opt.spell          = true
vim.opt.spellsuggest   = "best"
vim.opt.conceallevel   = 2
vim.opt.concealcursor  = ""
vim.opt.guicursor      = "a:Cursor/Cursor"
vim.opt.list           = true
vim.opt.laststatus     = 3
vim.opt.shortmess      = "oOstTWIcCFSqc"
vim.opt.mouse          = ""
vim.opt.confirm        = true
vim.opt.undofile       = true
vim.opt.undolevels     = 10000
vim.opt.expandtab      = true
vim.opt.shiftwidth     = 2
vim.opt.tabstop        = 2
vim.opt.softtabstop    = 2

vim.opt.fillchars:append({
  eob = " ",
  stl = "─",
  wbr = "─",
  horiz = " ",
  horizup = "│",
  horizdown = "│",
  vert = "│",
  vertleft = "│",
  vertright = "│",
  verthoriz = "│"
})

vim.opt.listchars:append({
  trail = "_",
  tab   = "> "
})

vim.g.markdown_recommended_style = 0
vim.g.loaded_netrwPlugin         = 1
vim.g.loaded_netrw               = 1
vim.g.loaded_2html_plugin        = 0
vim.g.loaded_fzf                 = 0
vim.g.loaded_zipPlugin           = 0
vim.g.loaded_node_provider       = 0
vim.g.loaded_ruby_provider       = 0
vim.g.loaded_perl_provider       = 0
vim.g.loaded_python3_provider    = 0

if vim.g.neovide then
  -- vim.opt.guifont   = "JetBrains Mono:h13.5"
  vim.opt.linespace = 3

  vim.g.neovide_cursor_unfocused_outline_width = 0

  vim.g.neovide_padding_top    = 24
  vim.g.neovide_padding_bottom = 24
  vim.g.neovide_padding_right  = 24
  vim.g.neovide_padding_left   = 24

  vim.g.neovide_transparency           = 0.85
  vim.g.neovide_normal_opacity         = 1.0
  vim.g.neovide_floating_blur_amount_x = 8192
  vim.g.neovide_floating_blur_amount_y = 8192

  vim.g.neovide_floating_shadow        = false
  vim.g.neovide_floating_z_height      = 10
  vim.g.neovide_light_angle_degrees    = 45
  vim.g.neovide_light_radius           = 2
  vim.g.neovide_floating_corner_radius = 0
  vim.g.experimental_layer_grouping    = false

  vim.g.neovide_position_animation_length     = 0
  vim.g.neovide_scroll_animation_length       = 0
  vim.g.neovide_cursor_animation_length       = 0
  vim.g.neovide_cursor_trail_size             = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line   = false

  vim.g.neovide_no_idle = false
end
