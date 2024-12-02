require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  ignore_install = { "all" },
  highlight = { enable = true },
  incremental_selection = { enable = false },
  indent = { enable = false }
})
