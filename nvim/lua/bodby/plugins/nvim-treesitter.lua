require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  sync_install = false,
  auto_install = false,
  ignore_install = { "all" },
  highlight = { enable = true },
  incremental_selection = { enable = false },
  indent = { enable = false }
})

local del = vim.api.nvim_del_user_command

vim.schedule(function()
  del "TSInstall"
  del "TSInstallFromGrammar"
  del "TSInstallSync"
  del "TSUpdate"
  del "TSUpdateSync"
  del "TSUninstall"
  del "TSModuleInfo"
  del "TSInstallInfo"
  del "TSConfigInfo"
  -- ?
  del "TSEditQuery"
  del "TSEditQueryUserAfter"
end)
