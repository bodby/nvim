local M = { }
-- TODO: I want to make the mapping tables of type table<string, mapping>
--       (with the key being the lhs instead of a separate lhs field), but
--       it is inefficient because I have to then loop through each one
--       separately. :(

--- @class mapping
--- @field lhs string
--- @field modes string
--- @field callback string | fun() : string?
--- @field opts? table

-- TODO: I don't think I need these.
-- local lsp_mappings = {
--   { lhs = "gd", modes = "nv", callback = vim.lsp.buf.definition },
--   { lhs = "grn", modes = "n", callback = vim.lsp.buf.rename },
--   { lhs = "gra", modes = "n", callback = vim.lsp.buf.code_action },
--   { lhs = "K", modes = "n", callback = vim.lsp.buf.hover }
-- }

--- Neovide zoom mappings.
--- @type table<string, mapping>
local zoom_mappings = {
  {
    lhs = "<C-+>",
    modes = "niv",
    callback = function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.125
    end
  },
  {
    lhs = "<C-_>",
    modes = "niv",
    callback = function()
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.125
    end
  },
  {
    lhs = "<C-)>",
    modes = "niv",
    callback = function()
      vim.g.neovide_scale_factor = 1.0
    end
  }
}

--- @type table<string, mapping>
local mappings = {
  -- Register mappings.
  { lhs = "<Leader>p", modes = "v", callback = '"_dP' },
  { lhs = "<Leader>P", modes = "v", callback = '"_dP' },
  { lhs = "<Leader>d", modes = "nv", callback = '"_d' },
  { lhs = "<Leader>D", modes = "nv", callback = '"_D' },
  { lhs = "<Leader>c", modes = "nv", callback = '"_c' },
  { lhs = "<Leader>C", modes = "nv", callback = '"_C' },
  { lhs = "<Leader>x", modes = "nv", callback = '"_x' },
  { lhs = "<Leader>X", modes = "nv", callback = '"_X' },
  { lhs = "<Leader>s", modes = "nv", callback = '"_s' },
  { lhs = "<Leader>S", modes = "nv", callback = '"_S' },

  -- System clipboard mappings.
  { lhs = "<Leader>y", modes = "nv", callback = '"+y' },
  { lhs = "<Leader>Y", modes = "nv", callback = '"+Y' },
  { lhs = "<Leader>p", modes = "n", callback = '"+p' },
  { lhs = "<Leader>P", modes = "n", callback = '"+P' },

  -- TODO: Is there a way to do this without ':normal'?
  --       Perhaps with 'expr'?
  { lhs = "<C-c>", modes = "nv", callback = "<Cmd>normal gcc<CR>" },
  {
    lhs = "<S-CR>",
    modes = "nivs",
    callback = function()
      if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
      end
    end
  }

  -- TODO: Do I need these, or are they defaults?
  --       I don't know if they work in Treesitter query files by default.
  -- ["]d"] = {
  --   modes = "n",
  --   callback = vim.diagnostic.goto_next
  -- },
  -- ["[d"] = {
  --   modes = "n",
  --   callback = vim.diagnostic.goto_prev
  -- },
  -- ["<C-w>d"] = {
  --   modes = "n",
  --   callback = vim.lsp.buf.hover
  -- }
}

--- Create a mapping.
--- @param modes string
--- @param lhs string
--- @param rhs string | fun()
--- @param opts? table
function M.map(modes, lhs, rhs, opts)
  local mode_tbl = vim.split(modes, "")
  vim.keymap.set(mode_tbl, lhs, rhs, opts or { })
end

--- Very efficient.
function M.setup()
  for _, v in ipairs(mappings) do
    M.map(v.modes, v.lhs, v.callback, v.opts)
  end

  if vim.g.neovide then
    for _, v in ipairs(zoom_mappings) do
      M.map(v.modes, v.lhs, v.callback, v.opts)
    end
  end
end

return M
