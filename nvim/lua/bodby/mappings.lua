local M = {}

--- @class (exact) Mapping
--- @field modes string
--- @field callback string | fun(): string? | table
--- @field opts? table

--- @type table<string, Mapping>
local mappings = {
  -- Register mappings.
  ['<Leader>d'] = { modes = 'nv', callback = '"_d' },
  ['<Leader>D'] = { modes = 'nv', callback = '"_D' },
  ['<Leader>c'] = { modes = 'nv', callback = '"_c' },
  ['<Leader>C'] = { modes = 'nv', callback = '"_C' },
  ['<Leader>x'] = { modes = 'nv', callback = '"_x' },
  ['<Leader>X'] = { modes = 'nv', callback = '"_X' },
  ['<Leader>s'] = { modes = 'nv', callback = '"_s' },
  ['<Leader>S'] = { modes = 'nv', callback = '"_S' },
  -- System clipboard mappings.
  ['<Leader>y'] = { modes = 'nv', callback = '"+y' },
  ['<Leader>Y'] = { modes = 'nv', callback = '"+Y' },
  ['<Leader>p'] = { modes = 'n', callback = '"+p' },
  ['<Leader>P'] = { modes = 'n', callback = '"+P' },
  -- Misc. mappings.
  ['<C-c>'] = { modes = 'nv', callback = '<Cmd>normal gcc<CR>' },
}

--- Neovide zoom mappings.
--- @type table<string, Mapping>
local neovide_mappings = {
  ['<C-+>'] = {
    modes = 'niv',
    callback = function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.125
    end,
  },
  ['<C-_>'] = {
    modes = 'niv',
    callback = function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.125
    end,
  },
  ['<C-)>'] = {
    modes = 'niv',
    callback = function()
      vim.g.neovide_scale_factor = 1.0
    end,
  },
}

--- Create a mapping.
--- @param modes string
--- @param lhs string
--- @param rhs string | fun()
--- @param opts? table
function M.map(modes, lhs, rhs, opts)
  local mode_tbl = vim.split(modes, '')
  vim.keymap.set(mode_tbl, lhs, rhs, opts or {})
end

--- Set up all mappings.
function M.setup()
  for k, v in pairs(mappings) do
    M.map(v.modes, k, v.callback, v.opts)
  end

  if vim.g.neovide then
    for k, v in pairs(neovide_mappings) do
      M.map(v.modes, k, v.callback, v.opts)
    end
  end
end

return M
