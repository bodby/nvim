local opt = vim.opt
local g = vim.g

opt.pumheight = 16
opt.scrolloff = 12
opt.showmode = false
opt.cmdheight = 0

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.numberwidth = 1
opt.signcolumn = "yes"

opt.wrap = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

opt.conceallevel = 2
opt.concealcursor = ""

opt.guicursor = "a:Cursor/Cursor"

opt.list = true
opt.listchars:append({ trail = "_" })
opt.fillchars:append({
  eob = " "
  -- stl = "─",
  -- wbr = "─"
})

opt.laststatus = 3
opt.shortmess = "oOstTWIcCFSqc"

opt.mouse = ""

opt.confirm = true
opt.undofile = true
opt.undolevels = 10000

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2

g.markdown_recommended_style = 0

g.loaded_netrwPlugin = 1
g.loaded_netrw = 1
g.loaded_2html_plugin = 0
g.loaded_fzf = 0
g.loaded_zipPlugin = 0

-- g.loaded_node_provider = 0
-- g.loaded_ruby_provider = 0
-- g.loaded_perl_provider = 0
-- g.loaded_python3_provider = 0
