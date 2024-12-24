local M = {}

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

function M.setup_lsp_mappings(opts)
  vim.keymap.set("n", "gd",     "<cmd>lua vim.lsp.buf.definition()<cr>",    opts)
  vim.keymap.set("n", "grn",    "<cmd>lua vim.lsp.buf.rename()<cr>",        opts)
  vim.keymap.set("n", "gra",    "<cmd>lua vim.lsp.buf.code_action()<cr>",   opts)
  vim.keymap.set("n", "K",      "<cmd>lua vim.lsp.buf.hover()<cr>",         opts)
  vim.keymap.set("n", "<C-w>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  vim.keymap.set("n", "]d",     "<cmd>lua vim.diagnostic.goto_next()<cr>",  opts)
  vim.keymap.set("n", "[d",     "<cmd>lua vim.diagnostic.goto_prev()<cr>",  opts)
end

return M
