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
vim.keymap.set("n", "<Leader>p", [["+p]])
vim.keymap.set("n", "<Leader>P", [["+P]])

-- Helix comment mapping.
vim.keymap.set({ "n", "v" }, "<C-c>", "<Cmd>normal gcc<CR>")

-- Snippets.
vim.keymap.set({ "n", "i", "v", "s" }, "<S-CR>", function()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  end
end)

-- Fix folds not updating when modifying files (I think).
-- TODO: Should this be here?
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function(event)
    vim.o.foldmethod = vim.o.foldmethod
  end
})

vim.keymap.set({ "n", "v" }, "za", function()
  vim.o.foldmethod = vim.o.foldmethod
  return "za"
end, {
  expr  = true,
  remap = false
})

function M.setup_lsp_mappings(opts)
  vim.keymap.set("n", "gd",     "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "grn",    "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "gra",    "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set("n", "K",      "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set("n", "<C-w>d", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.keymap.set("n", "]d",     "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.keymap.set("n", "[d",     "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
end

if vim.g.neovide then
  vim.keymap.set("n", "<C-+>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.125
  end)

  vim.keymap.set("n", "<C-_>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.125
  end)

  vim.keymap.set("n", "<C-)>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
end

return M
