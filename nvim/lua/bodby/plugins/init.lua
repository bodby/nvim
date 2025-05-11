--- @class (exact) Plugin
--- @field event? string
--- @field pattern? string
---
--- Mappings that get created after the plugin is configured.
--- These are deferred using `vim.schedule()`.
--- @field mappings? table<string, table<string, string | fun()>>
---
--- Per-plugin configuration options. These are passed to `setup()`.
--- @field opts? table
---
--- Called after the plugin is setup.
--- These are deferred using `vim.schedule()`.
--- @field post? fun()

--- @type table<string, string>
return {
  ['blink.cmp'] = 'blink-cmp',
  -- ['alpha'] = 'alpha',
  ['telescope'] = 'telescope',
  ['gitsigns'] = 'gitsigns',
  ['nvim-treesitter.configs'] = 'nvim-treesitter',
  -- ['mini.indentscope'] = 'indentscope',
  -- ['render-markdown'] = 'render-markdown',
  -- ['syntax-gaslighting'] = 'gaslighting',
}
