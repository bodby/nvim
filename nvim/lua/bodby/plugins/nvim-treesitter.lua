require("nvim-treesitter.configs").setup({
  ensure_installed      = { },
  sync_install          = false,
  auto_install          = false,
  ignore_install        = { "all" },
  highlight             = { enable = true },
  incremental_selection = { enable = false },
  indent                = { enable = false }
})

vim.schedule(function()
  vim.api.nvim_del_user_command "TSInstall"
  vim.api.nvim_del_user_command "TSInstallFromGrammar"
  vim.api.nvim_del_user_command "TSInstallSync"
  vim.api.nvim_del_user_command "TSUpdate"
  vim.api.nvim_del_user_command "TSUpdateSync"
  vim.api.nvim_del_user_command "TSUninstall"
  vim.api.nvim_del_user_command "TSModuleInfo"
  vim.api.nvim_del_user_command "TSInstallInfo"
  vim.api.nvim_del_user_command "TSConfigInfo"
  vim.api.nvim_del_user_command "TSEditQuery"
  vim.api.nvim_del_user_command "TSEditQueryUserAfter"
end)
