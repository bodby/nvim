local ui = require('bodby.shared').ui
local with_args = require('bodby.shared').lib.with_args

local M = {}

--- @type table<string, table<string, string | fun()>>
local mappings = {
  ['n'] = {
    ['<Esc>'] = vim.cmd.nohlsearch,
    ['gd'] = vim.lsp.buf.definition,
    -- TODO: Make this fallback to opening help buffers.
    ['K'] = with_args(vim.lsp.buf.hover, { border = ui.border.name }),
  },

  ['nivs'] = {
    ['<S-CR>'] = with_args(vim.snippet.jump, 1),
  },
}

--- Neovide zoom mappings.
--- @type table<string, table<string, string | fun()>>
local neovide_mappings = {
  ['n'] = {
    ['<C-+>'] = function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.125
    end,

    ['<C-_>'] = function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.125
    end,

    ['<C-)>'] = function()
      vim.g.neovide_scale_factor = 1.0
    end,
  },
}

--- @param t table<string, table<string, string | fun()>>
--- @param opts? table
function M.map(t, opts)
  for mode, v in pairs(t) do
    local modes = vim.split(mode, '')
    for lhs, rhs in pairs(v) do
      vim.keymap.set(modes, lhs, rhs, opts or {})
    end
  end
end

function M.setup()
  M.map(mappings)
  if vim.g.neovide then
    M.map(neovide_mappings)
  end

  -- I don't like the default snippet jump mappings.
  vim.keymap.del({ 'i', 's' }, '<Tab>')
  vim.keymap.del({ 'i', 's' }, '<S-Tab>')
end

return M
