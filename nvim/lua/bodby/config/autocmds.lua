vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "alpha" then
      pcall(vim.treesitter.start)
    end
  end
})

-- Hide cursor in dashboard. Not UIEnter because I could run ':Alpha'.
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function(_)
--     if vim.bo.filetype ~= "alpha" then
--       vim.opt.guicursor = "a:Cursor/Cursor"
--       vim.opt_local.statuscolumn = require "bodby.native.statuscolumn"
--     else
--       vim.opt.guicursor = "a:DashboardCursor/DashboardCursor"
--       vim.opt_local.statuscolumn = ""
--     end
--   end
-- })

-- LSP mappings.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    require("bodby.config.mappings").setup_lsp_mappings({ buffer = event.buffer })
  end
})
