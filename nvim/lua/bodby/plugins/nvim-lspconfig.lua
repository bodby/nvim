local cmp_caps  = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require "lspconfig"

local servers = {
  "clangd",
  "nixd",
  "ocamllsp",
  "rust_analyzer",
  "mesonlsp",
  "hls"
}

for _, server in pairs(servers) do
  lspconfig[server].setup({ capabilities = cmp_caps })
end
