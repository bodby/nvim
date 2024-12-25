vim.opt.pumheight      = 16
vim.opt.scrolloff      = 12
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

vim.opt.fillchars:append({ eob = " " })
vim.opt.listchars:append({
  trail = "_",
  tab   = ">-"
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
