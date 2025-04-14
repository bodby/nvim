local ui = require('bodby.shared').ui

--- @type table<string, table>
local servers = {
  ['clangd'] = {
    cmd = { 'clangd', '--background-index' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = {
      '.clangd',
      'compile_commands.json',
      'compile_flags.txt',
    },
  },
  ['nixd'] = {
    cmd = { 'nixd' },
    filetypes = { 'nix' },
  },
  ['tinymist'] = {
    cmd = { 'tinymist' },
    filetypes = { 'typst' },
  },
  ['rust-analyzer'] = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = {
      'Cargo.toml',
      'rust-project.json',
    },
  },
  ['markdown-oxide'] = {
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
  ['haskell-language-server'] = {
    cmd = { 'haskell-language-server' },
    filetypes = { 'haskell' },
    settings = {
      haskell = {
        maxCompletions = 100,
        checkProject = false,
        checkParents = 'CheckOnSave',
      },
    },
  },
  ['luals'] = {
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

vim.lsp.config('*', {
  root_markers = { 'flake.nix', '.git/' },
})

for k, v in pairs(servers) do
  if type(v) == 'table' then
    vim.lsp.config(k, v)
    vim.lsp.enable(k)
  else
    vim.lsp.enable(v)
  end
end

vim.diagnostic.config(diag_config)
