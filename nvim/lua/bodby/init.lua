require "bodby.config.options"
require "bodby.config.autocmds"

vim.cmd.colorscheme "degraded"

vim.g.mapleader = " "

vim.schedule(function()
  require "bodby.config.mappings"
end)

vim.api.nvim_create_augroup("status", {})

require("bodby.native.statusline").setup()
require("bodby.native.statuscolumn").setup()
-- require("bodby.native.winbar").setup()
-- require "bodby.plugins"

-- Calls 'require' on every plugin in table when the event fires.
local function lazy_load(plugins, event)
  local augroup = "lazy" .. event:lower()
  vim.api.nvim_create_augroup(augroup, {})

  vim.api.nvim_create_autocmd(event, {
    group = augroup,
    callback = function()
      for _, plugin in pairs(plugins) do
        require ("bodby.plugins." .. plugin)
      end
      vim.api.nvim_clear_autocmds({
        group = augroup
      })
    end
  })
end

-- Loaded on startup.
require "bodby.plugins.alpha-nvim"
require "bodby.plugins.telescope-nvim"

-- The order of the plugin names matters.
lazy_load({
  "blink-cmp",
  -- "blink-indent",
  "gitsigns-nvim"
}, "BufEnter")
