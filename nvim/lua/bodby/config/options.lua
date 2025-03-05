-- FIXME: Move all 'vim.opt' lines to 'vim.o'.
vim.o.pumheight      = 16
vim.o.scrolloff      = 12
vim.o.showmode       = false
vim.o.cmdheight      = 0
vim.o.number         = true
vim.o.relativenumber = true
vim.o.cursorline     = true
vim.o.numberwidth    = 1
vim.o.signcolumn     = "yes"
vim.o.wrap           = true
vim.o.hlsearch       = false
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.spelllang      = "en"
vim.o.spell          = false
vim.o.spellsuggest   = "best"
vim.o.conceallevel   = 0
vim.o.concealcursor  = ""
vim.o.guicursor      = "a:Cursor/Cursor"
vim.o.list           = true
vim.o.laststatus     = 3
vim.o.showtabline    = 2
vim.o.shortmess      = "oOstTWIcCFSqc"
vim.o.mouse          = ""
vim.o.confirm        = true
vim.o.undofile       = true
vim.o.undolevels     = 10000
vim.o.expandtab      = true
vim.o.shiftwidth     = 2
vim.o.tabstop        = 2
vim.o.softtabstop    = 2
vim.o.foldenable     = true
vim.o.foldmethod     = "expr"
vim.o.foldexpr       = "nvim_treesitter#foldexpr()"
vim.o.foldlevel      = 99
vim.o.foldtext       = ""
vim.o.foldnestmax    = 4

-- FIXME: Move 'opt' to 'o'.
--        https://github.com/neovim/neovim/issues/20107
vim.opt.fillchars:append({
  eob  = " ",
  stl  = " ",
  wbr  = " ",
  fold = " "
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
  -- https://github.com/neovide/neovide/issues/2491
  -- vim.o.guifont = "JetBrains Mono:h13.5"

  vim.g.neovide_text_gamma    = 1.2
  vim.g.neovide_text_contrast = 0.0

  vim.o.linespace = 6
  vim.g.neovide_padding_top    = 24
  vim.g.neovide_padding_bottom = 24
  vim.g.neovide_padding_right  = 24
  vim.g.neovide_padding_left   = 24

  vim.g.neovide_cursor_unfocused_outline_width = 0

  vim.g.neovide_confirm_quit = true

  vim.g.neovide_transparency           = 1.0
  vim.g.neovide_normal_opacity         = 1.0
  vim.g.neovide_floating_blur_amount_x = 0
  vim.g.neovide_floating_blur_amount_y = 0

  vim.g.neovide_floating_shadow        = false
  vim.g.neovide_floating_corner_radius = 0
  vim.g.experimental_layer_grouping    = false

  vim.g.neovide_position_animation_length     = 0.2
  vim.g.neovide_scroll_animation_length       = 0.2
  vim.g.neovide_scroll_animation_far_lines    = 0
  vim.g.neovide_cursor_animation_length       = 0.06
  vim.g.neovide_cursor_trail_size             = 0.4
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line   = true

  vim.g.neovide_no_idle = false
end
