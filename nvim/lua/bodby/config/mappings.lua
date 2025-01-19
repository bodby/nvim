local M = { }

vim.keymap.set("v",          "<Leader>p", [["_dP]])
vim.keymap.set("v",          "<Leader>P", [["_dP]])
vim.keymap.set({ "n", "v" }, "<Leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<Leader>D", [["_D]])
vim.keymap.set({ "n", "v" }, "<Leader>c", [["_c]])
vim.keymap.set({ "n", "v" }, "<Leader>C", [["_C]])
vim.keymap.set({ "n", "v" }, "<Leader>x", [["_x]])
vim.keymap.set({ "n", "v" }, "<Leader>X", [["_X]])
vim.keymap.set({ "n", "v" }, "<Leader>s", [["_s]])
vim.keymap.set({ "n", "v" }, "<Leader>S", [["_S]])

vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<Leader>Y", [["+Y]])

-- System clipboard.
-- You can use this insert using 'Ctrl+O' -> 'Space p/P'
vim.keymap.set("n", "<Leader>p", [["+p]])
vim.keymap.set("n", "<Leader>P", [["+P]])

-- Helix uses Ctrl+C to comment.
-- I can still use 'gcj' and 'gck', etc. for multiple lines.
vim.keymap.set({ "n", "v" }, "<C-c>", "<Cmd>normal gcc<CR>")

function M.setup_lsp_mappings(opts)
  vim.keymap.set("n", "gd",     "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "grn",    "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "gra",    "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set("n", "K",      "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set("n", "<C-w>d", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.keymap.set("n", "]d",     "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.keymap.set("n", "[d",     "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
end

return M
