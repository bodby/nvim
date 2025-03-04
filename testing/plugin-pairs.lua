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
  ["nvim-pathwalker"] = {
    event = "FileType",
    pattern = "lua",
    opts = { foo = "pw" }
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
    pattern = "",
    opts = { foo = "none" }
  },
  ["no-event-too"] = {
    event = "",
    pattern = nil,
    opts = { foo = "none2" }
  }
}

local grouped = { }

for k, v in pairs(plugins) do
  local has_event = v.event and v.event ~= ""

  if has_event then
    local pattern = v.pattern ~= nil and v.pattern ~= "" and v.pattern or "*"

    if not grouped[v.event] then
      grouped[v.event] = { }
    end

    if not grouped[v.event][pattern] then
      grouped[v.event][pattern] = { }
    end

    table.insert(grouped[v.event][pattern], k)
  else
    print("Setting up " .. k .. " with config " .. v.opts.foo)
  end
end

print(vim.inspect(grouped))

for event, patterns in pairs(grouped) do
  for pattern, modules in pairs(patterns) do
    print("Setting up all plugins using autocmd " .. event .. " under pattern " .. pattern)
    for _, plugin in ipairs(modules) do
      print("- Setup " .. plugin .. " with opts " .. plugins[plugin].opts.foo)
    end
  end
end
