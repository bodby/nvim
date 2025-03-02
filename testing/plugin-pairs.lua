local plugins = {
  ["nvim-lspconfig"] = {
    event = "BufEnter",
    pattern = "src/*.c",
    opts = { foo = "lsp" }
  },
  ["nvim-treesitter"] = {
    event = "FileType",
    pattern = "lua",
    opts = { foo = "ts" }
  },
  ["nvim-align"] = {
    event = "BufEnter",
    pattern = nil,
    opts = { foo = "al" }
  },
  ["dummy-plugin"] = {
    event = "FileType",
    pattern = "rust",
    opts = { foo = "bar" }
  },
  ["no-event"] = {
    event = nil,
    opts = { foo = "none" }
  }
}
local grouped = { }

for k, v in pairs(plugins) do
  if v.event then
    local pattern = (v.pattern ~= nil and v.pattern ~= "") and v.pattern or "*"

    local entry = v.event .. "/" .. pattern
    if not grouped[entry] then
      grouped[entry] = { plugins = { } }
    end

    table.insert(grouped[entry].plugins, k)
  else
    print("Setting up " .. k .. " with config " .. v.opts.foo)
  end
end

print(vim.inspect(grouped))

for k, p in pairs(grouped) do
  local autocmd = vim.split(k, "/")
  local cmd = autocmd[1]
  local pattern = k:sub(#cmd + 2)

  print("Setting up all plugins using autocmd " .. cmd .. " under pattern " .. pattern)
  for _, v in ipairs(p.plugins) do
    print("- Setup " .. v .. " with opts " .. plugins[v].opts.foo)
  end
end
