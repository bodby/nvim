local cmp_caps = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require "lspconfig"

lspconfig.clangd.setup({
  capabilities = cmp_caps
})

lspconfig.nixd.setup({
  capabilities = cmp_caps
})

lspconfig.ocamllsp.setup({
  capabilities = cmp_caps
})

lspconfig.rust_analyzer.setup({
  capabilities = cmp_caps
})

lspconfig.mesonlsp.setup({
  capabilities = cmp_caps
})
