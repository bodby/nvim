local nil_str = require('bodby.shared').lib.nil_str
local mappings = require('bodby.mappings')

vim.cmd.colorscheme('bodby')
require('bodby.options')

vim.g.mapleader = ' '
mappings.setup()
require('bodby.lsp')

-- TODO: Allow these to be configured like other plugins.
--       And decide on either 'buffer' and 'window' or 'bufnr' and 'winid'.
vim
  .iter({
    'statusline',
    'statuscolumn',
    'tabline',
    -- TODO: Winbar with Treesitter breadcrumbs.
    -- 'winbar',
    -- TODO: Indent lines with customizable start and end character.
    --       Also doesn't show if the scope is only a single line.
    -- 'indent',
    'notes',
  })
  :map(function(t)
    require('bodby.native.' .. t).setup()
  end)

--- @type table<string, string>
local plugins = require('bodby.plugins')

--- @type { [string]: table<string, string[]> }
local mapped = {}

--- @type table<string, Plugin>
local config = vim.iter(plugins):fold({}, function(acc, k, v)
  acc[k] = require('bodby.plugins.' .. v)
  return acc
end)

--- @param plugin string
local function setup(plugin)
  --- @type Plugin
  local options = config[plugin]
  require(plugin).setup(options.opts or {})

  vim.schedule(function()
    if options.mappings then
      mappings.map(options.mappings)
    end
    if options.post then
      options.post()
    end
  end)
end

for p, o in pairs(config) do
  --- @type boolean
  local has_event = not nil_str(o.event)
  if has_event then
    --- @type string
    local pattern = not nil_str(o.pattern) and o.pattern or '*'
    mapped[o.event] = mapped[o.event] or {}
    mapped[o.event][pattern] = mapped[o.event][pattern] or {}

    table.insert(mapped[o.event][pattern], p)
  else
    setup(p)
  end
end

for ev, ps in pairs(mapped) do
  for p, vs in pairs(ps) do
    local group = 'Lazy' .. ev .. p
    vim.api.nvim_create_augroup(group, { clear = true })
    vim.api.nvim_create_autocmd(ev, {
      group = group,
      pattern = p,
      callback = function()
        for _, x in ipairs(vs) do
          setup(x)
          vim.api.nvim_clear_autocmds({ group = group })
        end
      end,
    })
  end
end
