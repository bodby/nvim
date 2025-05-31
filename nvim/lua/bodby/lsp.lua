local ui = require('bodby.shared').ui

--- @type table<string, table>
local servers = {
  -- TODO: Haskell.
  --       Now I understand what rexim meant about horrible tooling.

  c = {
    cmd = { 'clangd', '--background-index' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = {
      '.clangd',
      'compile_commands.json',
      'compile_flags.txt',
    },
  },

  nix = {
    cmd = { 'nixd' },
    filetypes = { 'nix' },
  },

  typst = {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
  },

  rust = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = {
      'Cargo.toml',
      'clippy.toml',
      'rustfmt.toml',
      'rust-project.json',
    },
  },

  markdown = {
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  },

  lua = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
      '.luarc.json',
      'stylua.toml',
      '.stylua.toml',
      '.luacheckrc',
    },

    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
          keywordSnippet = 'Disable',
          showWord = 'Disable',
        },

        type = {
          weakNilCheck = true,
          weakUnionCheck = true,
        },

        format = { enable = false },
        hint = { enable = false },
        telemetry = { enable = false },
        semantic = { variable = false },
      },
    },

    on_init = function(client)
      local path = client.workspace_folders and client.workspace_folders[1].name
        or vim.fn.getcwd()

      local json = vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.json'))
      local jsonc = vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.jsonc'))
      if json or jsonc then
        return
      end

      client.config.settings.Lua =
        vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },

          diagnostics = {
            globals = { 'vim' },
          },

          workspace = {
            library = { vim.env.VIMRUNTIME },
            checkThirdParty = false,
          },
        })
    end,
  },
}

--- @type table<string, any>
local diag_config = {
  underline = false,
  virtual_text = { current_line = true },
  virtual_lines = false,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'X',
      [vim.diagnostic.severity.WARN] = '!',
      [vim.diagnostic.severity.INFO] = 'i',
      [vim.diagnostic.severity.HINT] = '?',
    },
  },

  float = {
    scope = 'line',
    severity_sort = true,
    header = '',
    source = false,
    prefix = ' ',
    suffix = ' ',
    border = ui.border.name,
  },
}

local default = {
  root_markers = {
    'flake.nix',
    '.git/',
  },
}

vim.diagnostic.config(diag_config)
for k, v in pairs(servers) do
  vim.lsp.config(k, v or default)
  vim.lsp.enable(k)
end
