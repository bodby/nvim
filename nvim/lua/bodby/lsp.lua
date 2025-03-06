local lspconfig = require("lspconfig")
local caps = require("blink.cmp").get_lsp_capabilities()

-- TODO: Add markdown-oxide and TexLab.
local servers = {
  -- TODO: Can I configure clangd without a .clangd?
  ["clangd"] = {
    settings = {
      InlayHints = { Enabled = false },
      Hover = { ShowAKA = true }
    }
  },

  "nixd",
  "ocamllsp",
  "rust_analyzer",
  "mesonlsp",

  ["hls"] = {
    settings = {
      haskell = {
        maxCompletions = 100,
        checkProject = false,
        checkParents = "CheckOnSave"
      }
    }
  },
  ["lua_ls"] = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";")
        },

        diagnostics = {
          globals = { "vim" }
        },

        workspace = {
          library = { vim.env.VIMRUNTIME },
          checkThirdParty = false
        },

        completion = {
          callSnippet = "Replace",
          keywordSnippet = "Disable"
        },

        type = {
          weakNilCheck = true,
          weakUnionCheck = true
        },

        format = { enable = false },
        hint = { enable = false },
        telemetry = { enable = false },
        semantic = { variable = false }
      }
    }
  }
}

local capabilities = { capabilities = caps }
for k, v in pairs(servers) do
  if type(k) == "table" then
    lspconfig[v].setup(vim.tbl_deep_extend("force", k, capabilities))
  else
    lspconfig[k].setup(capabilities)
  end
end
