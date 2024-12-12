vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    require("bodby.config.mappings").setup_lsp_mappings({ buffer = event.buf })
  end
})
