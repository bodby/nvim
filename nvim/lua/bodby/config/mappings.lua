-- Plugin mappings can be found in their respective file.
local map = vim.keymap.set

local M = {}

vim.g.mapleader = " "

map("v", "<leader>p", [["_dP]])
map("v", "<leader>P", [["_dP]])

map({ "n", "v" }, "<leader>d", [["_d]])
map({ "n", "v" }, "<leader>D", [["_D]])
map({ "n", "v" }, "<leader>c", [["_c]])
map({ "n", "v" }, "<leader>C", [["_C]])
map({ "n", "v" }, "<leader>x", [["_x]])
map({ "n", "v" }, "<leader>X", [["_X]])
map({ "n", "v" }, "<leader>s", [["_s]])
map({ "n", "v" }, "<leader>S", [["_S]])

-- Yank to system clipboard.
map({ "n", "v" }, "<leader>y", [["+y]])
map({ "n", "v" }, "<leader>Y", [["+Y]])

function M.setup_lsp_mappings(opts)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

  map("n", "grn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  map("n", "<C-w>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  map("n", "gra", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  -- map("n", "grr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)

  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
end

return M
