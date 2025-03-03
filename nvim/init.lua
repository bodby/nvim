vim.cmd.colorscheme("dark")
require("bodby.config.options")

vim.schedule(function()
  vim.g.mapleader = " "
  require("bodby.config.mappings")
end)

-- TODO: Move this into native plugin code and set 'clear = false'?
vim.api.nvim_create_augroup("status", { })

-- TODO: Allow these to be configured like other plugins.
require("bodby.native.statusline").setup()
require("bodby.native.statuscolumn").setup()
require("bodby.native.tabline").setup()

--- @type table<string, plugin>
local plugins = require("bodby.plugins")
local grouped = { }

-- Map plugins to the 'grouped' table, or set them up immediately if they have
-- no event defined.
for k, v in pairs(plugins) do
  if v.event then
    local pattern = (v.pattern and v.pattern ~= "") and v.pattern or "*"
    local entry = v.event .. "/" .. pattern
    if not grouped[entry] then
      grouped[entry] = { plugins = { } }
    end
    table.insert(grouped[entry].plugins, k)
  else
    require(k).setup(v.opts)
  end
end

-- Create autocommands for each filetype and pattern pair.
for k, v in pairs(grouped) do
  local autocmd = vim.split(k, "/")
  local event = autocmd[1]
  local pattern = k:sub(#event + 2)

  local group = "Lazy" .. event .. pattern
  vim.api.nvim_create_augroup(group, { })

  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      for _, plugin in ipairs(v.plugins) do
        require(plugin).setup(plugins[plugin].opts)
      end
    end
  })
end
