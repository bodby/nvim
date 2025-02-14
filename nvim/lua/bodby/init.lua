require "bodby.config.options"

vim.cmd.colorscheme "dark"

vim.g.mapleader = " "

-- Why does NvChad defer mappings?
vim.schedule(function()
  local lsp_signs = {
    Error = "x",
    Warn  = "!",
    Hint  = "?",
    Info  = "i"
  }

  for type, sign in pairs(lsp_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
      text   = sign,
      texthl = hl,
      numhl  = hl
    })
  end

  require "bodby.config.mappings"

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      require("bodby.config.mappings").setup_lsp_mappings({ buffer = event.buf })
    end
  })
end)

vim.api.nvim_create_augroup("status", { })

require("bodby.native.statusline").setup()
require("bodby.native.statuscolumn").setup()
-- require("bodby.native.winbar").setup()
require("bodby.native.tabline").setup()
require "bodby.native.commentstring"

local function lazy_load(plugins, event, pattern)
  local augroup = "lazy" .. event:lower() .. string.gsub(pattern, "ft", "*.")

  vim.api.nvim_create_augroup(augroup, { })
  vim.api.nvim_create_autocmd(event, {
    group    = augroup,
    pattern  = pattern,
    callback = function()
      for _, plugin in pairs(plugins) do
        require("bodby.plugins." .. plugin)
      end

      vim.api.nvim_clear_autocmds({
        group = augroup
      })
    end
  })
end

require "bodby.plugins.telescope-nvim"
require "bodby.plugins.alpha-nvim"
require "bodby.plugins.nvim-lspconfig"

lazy_load({
  "blink-cmp",
  -- "indentmini-nvim",
  -- "blink-indent",
  -- "hlargs-nvim",
  "gitsigns-nvim",
  "smartcolumn-nvim",
  "nvim-treesitter",
  "nvim-align"
}, "BufEnter", "*")

lazy_load({
  "render-markdown"
}, "FileType", "markdown")
