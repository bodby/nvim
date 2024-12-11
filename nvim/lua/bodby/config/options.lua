local o = vim.opt
local g = vim.g

local signs = {
  Error = "x",
  Warn = "!",
  Hint = "?",
  Info = "i"
}

-- Visual
o.pumheight = 16
o.scrolloff = 12
o.showmode = false
o.cmdheight = 0

o.number = true
o.relativenumber = true
o.cursorline = true
o.numberwidth = 1
o.signcolumn = "yes"

o.wrap = true
o.hlsearch = false
o.ignorecase = true
o.smartcase = true

o.conceallevel = 2
o.concealcursor = ""

o.guicursor = "a:Cursor/Cursor"

o.list = true
o.listchars:append({ trail = "_" })
o.fillchars:append({
  eob = " "
  -- stl = "─",
  -- wbr = "─"
})

o.laststatus = 3
o.shortmess = "oOstTWIcCFSqc"

-- LSP statuscolumn icons.
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = hl
  })
end

-- Functional.
o.mouse = ""

o.confirm = true
o.undofile = true
o.undolevels = 10000

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

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
