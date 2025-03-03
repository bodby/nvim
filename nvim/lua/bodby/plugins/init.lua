--- @module "bodby.plugins"
--- @type plugin

--- @class plugin
--- @field event string
--- @field pattern string
--- @field opts table

local plugins = {
  ["blink.cmp"] = "blink-cmp",
  ["alpha"] = "alpha"
  -- ["gitsigns"] = "gitsigns",
  -- ["nvim-treesitter.configs"] = "nvim-treesitter",
  -- ["render-markdown"] = "render-markdown",
  -- ["smartcolumn"] = "smart-column",
  -- ["virt-column"] = "virt-column",
  -- ["telescope"] = "telescope"
}

return vim.tbl_map(function(p)
  return require("bodby.plugins." .. p)
end, plugins)
