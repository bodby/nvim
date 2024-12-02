vim.api.nvim_create_augroup("status", {})

require("bodby.native.statusline").setup()
require("bodby.native.statuscolumn").setup()
-- require("bodby.native.winbar").setup()
