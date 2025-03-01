local lspconfig = require "lspconfig"
local cmp_caps  = require("blink.cmp").get_lsp_capabilities()

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

-- TODO: Further customization.
vim.diagnostic.config({
  underline        = true,
  virtual_text     = false,
  update_in_insert = true,
  severity_sort    = true,

  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'X',
      [vim.diagnostic.severity.WARN]  = '!',
      [vim.diagnostic.severity.INFO]  = 'i',
      [vim.diagnostic.severity.HINT]  = '?'
    }
  },

  float = {
    scope         = "line",
    severity_sort = true,
    -- header        = { "Diagnostics", "FloatTitle" },
    header        = "",
    prefix        = ""
  }
})

-- FIXME: Change the 'servers' table to a dictionary with per-LSP config options.
lspconfig["lua_ls"].setup({
  capabilities = cmp_caps,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path    = vim.split(package.path, ";")
      },

      diagnostics = {
        globals       = { "vim" },
        workspaceRate = 100
      },

      workspace = {
        library         = { vim.env.VIMRUNTIME },
        preloadFileSize = 10000,
        checkThirdParty = false
      },

      completion = {
        autoRequire      = true,
        callSnippet      = "Replace",
        keywordSnippet   = "Disable",
        requireSeparator = ".",
        showWord         = "Enable",
        workspaceWord    = true
      },

      type = {
        weakNilCheck   = true,
        weakUnionCheck = true
      },

      format    = { enable = false },
      hint      = { enable = false },
      telemetry = { enable = false },
      semantic  = { variable = false }
    }
  }
})
